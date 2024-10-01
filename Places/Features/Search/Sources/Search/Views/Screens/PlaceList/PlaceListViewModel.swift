//
//  PlaceListViewModel.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Deeplink
import Foundation

@Observable
public final class PlaceListViewModel: PlaceListViewModelProtocol {    
    var state: PlaceListViewState = .loading
    private var places: [Place] = []
    private var placeFiltered: [Place] = []
    private let repository: SearchRepositoryProtocol
    
    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    func requestPlaces() async {
        state = .loading
        
        do {
            places = try await repository.requestPlaces()
            state = .loaded(places)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func searchPlaces(_ searchQuery: String) {
        if searchQuery.isEmpty {
            placeFiltered = places
        } else {
            placeFiltered = places.filter { place in
                place.name
                    .lowercased()
                    .hasPrefix(searchQuery)
            }
        }
        
        state = .loaded(placeFiltered)
    }
}

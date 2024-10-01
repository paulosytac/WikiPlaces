//
//  PlaceListViewModel.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import protocol Deeplink.DeeplinkProtocol
import enum Deeplink.DeeplinkType
import Foundation

@Observable
public final class PlaceListViewModel: PlaceListViewModelProtocol {    
    var state: PlaceListViewState = .loading
    private var places: [Place] = []
    private var placeFiltered: [Place] = []
    private let repository: SearchRepositoryProtocol
    private let deeplink: DeeplinkProtocol
    
    public init(repository: SearchRepositoryProtocol, deeplink: DeeplinkProtocol) {
        self.repository = repository
        self.deeplink = deeplink
    }
    
    @MainActor
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
    
    @MainActor
    func openPlace(_ place: Place) async {
        let latitudeQueryItem = URLQueryItem(name: DeeplinkKeys.latitude, value: "\(place.latitude)")
        let longitudeQueryItem = URLQueryItem(name: DeeplinkKeys.longitude, value: "\(place.longitude)")
        let nameQueryItem = URLQueryItem(name: DeeplinkKeys.name, value: "\(place.name)")
        
        await deeplink.openWiki(
            [latitudeQueryItem, longitudeQueryItem, nameQueryItem],
            type: .places
        )
    }
}

extension PlaceListViewModel {
    private enum DeeplinkKeys {
        static let latitude = "lat"
        static let longitude = "long"
        static let name = "name"
    }
}



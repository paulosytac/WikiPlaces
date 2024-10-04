//
//  PlaceListViewModel.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import protocol Deeplink.DeeplinkProtocol
import enum Deeplink.DeeplinkType
import DependencyContainer
import Foundation

@Observable
public final class PlaceListViewModel: PlaceListViewModelProtocol {
    @ObservationIgnored @Injected var deeplink: DeeplinkProtocol
    @ObservationIgnored @Injected var repository: SearchRepositoryProtocol
    private var places: [Place] = []
    private var placeFiltered: [Place] = []
    public var state: PlaceListViewState = .loading
    
    public init() {}

    @MainActor
    public func requestPlaces() async {
        state = .loading
        
        do {
            places = try await repository.requestPlaces()
            state = .loaded(places)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    public func searchPlaces(_ searchQuery: String) async {
        if searchQuery.isEmpty {
            placeFiltered = places
        } else {
            let searchQuery = searchQuery.lowercased()
            
            placeFiltered = places.filter { place in
                place.name
                    .lowercased()
                    .hasPrefix(searchQuery)
            }
        }
        
        state = .loaded(placeFiltered)
    }
    
    @MainActor
    public func openPlace(_ place: Place) async {
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



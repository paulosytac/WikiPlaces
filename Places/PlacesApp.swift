//
//  PlacesApp.swift
//  Places
//
//  Created by Paulo Correa on 27/09/2024.
//

import class Deeplink.Deeplink
import protocol Deeplink.DeeplinkOpenerProtocol
import SwiftUI
import class Search.PlaceListViewModel
import struct Search.PlaceListView
import class Search.SearchRepository
import class Network.Network

@main
struct PlacesApp: App {
    @State private var placeListViewModel = PlaceListViewModel(
        repository: SearchRepository(
            network: Network()
        ),
        deeplink: Deeplink(
            deeplinkOpener: UIApplication.shared
        )
    )
    
    var body: some Scene {
        WindowGroup {
            PlaceListView()
                .environment(placeListViewModel)
        }
    }
}

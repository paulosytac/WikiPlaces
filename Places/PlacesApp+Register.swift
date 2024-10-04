//
//  PlacesApp+Register.swift
//  Places
//
//  Created by Paulo Correa on 04/10/2024.
//

import class Deeplink.Deeplink
import protocol Deeplink.DeeplinkProtocol
import protocol Deeplink.DeeplinkOpenerProtocol
import DependencyContainer
import class Network.Network
import protocol Network.NetworkProtocol
import class Search.PlaceListViewModel
import protocol Search.PlaceListViewModelProtocol
import class Search.SearchRepository
import protocol Search.SearchRepositoryProtocol
import SwiftUI

extension PlacesApp {
    func registerServices() {
        DependencyContainer.register(
            type: NetworkProtocol.self,
            Network()
        )
        
        DependencyContainer.register(
            type: SearchRepositoryProtocol.self,
            SearchRepository()
        )
        
        DependencyContainer.register(
            type: DeeplinkProtocol.self,
            Deeplink(deeplinkOpener: UIApplication.shared)
        )
        
        DependencyContainer.register(
            type: PlaceListViewModelProtocol.self,
            PlaceListViewModel()
        )
    }
}

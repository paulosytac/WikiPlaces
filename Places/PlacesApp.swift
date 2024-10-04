//
//  PlacesApp.swift
//  Places
//
//  Created by Paulo Correa on 27/09/2024.
//

import struct Search.PlaceListView
import SwiftUI

@main
struct PlacesApp: App {
    init() {
        registerServices()
    }
    
    var body: some Scene {
        WindowGroup {
            PlaceListView()
        }
    }
}



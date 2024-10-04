//
//  PlaceListViewModelProtocol.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Foundation

public enum PlaceListViewState: Equatable {
    case loading
    case loaded([Place])
    case error(String)
}

@MainActor
public protocol PlaceListViewModelProtocol {
    var state: PlaceListViewState { get }
    
    func requestPlaces() async
    func searchPlaces(_ searchQuery: String) async
    func openPlace(_ place: Place) async
}

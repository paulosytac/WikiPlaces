//
//  PlaceListViewModelProtocol.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Foundation

protocol PlaceListViewModelProtocol {
    var state: PlaceListViewState { get }
    
    func requestPlaces() async
    func searchPlaces(_ searchQuery: String)
}

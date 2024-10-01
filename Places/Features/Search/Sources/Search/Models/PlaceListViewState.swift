//
//  PlaceListViewState.swift
//  Search
//
//  Created by Paulo Correa on 30/09/2024.
//

enum PlaceListViewState: Equatable {
    case loading
    case loaded([Place])
    case error(String)
}

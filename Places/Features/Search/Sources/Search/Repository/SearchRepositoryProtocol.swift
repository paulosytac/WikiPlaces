//
//  SearchRepositoryProtocol.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

@MainActor
public protocol SearchRepositoryProtocol {
    func requestPlaces() async throws -> [Place]
}

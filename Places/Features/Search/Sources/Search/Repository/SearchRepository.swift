//
//  SearchRepository.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import DependencyContainer
import protocol Network.NetworkProtocol
import struct Network.NetworkRequest
import Foundation

public final class SearchRepository: SearchRepositoryProtocol {
    @Injected private var network: NetworkProtocol
    
    public init() {}

    @MainActor
    public func requestPlaces() async throws -> [Place] {
        try await network.request(.places()).places
    }
}

extension NetworkRequest {
    static func places() -> NetworkRequest<Places> {
        let urlString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        return NetworkRequest<Places>(
            method: .get,
            url: url
        )
    }
}

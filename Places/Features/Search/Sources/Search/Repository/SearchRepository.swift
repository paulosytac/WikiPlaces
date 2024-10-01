//
//  SearchRepository.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import protocol Network.NetworkProtocol
import struct Network.NetworkRequest
import Foundation

public final class SearchRepository: SearchRepositoryProtocol {
    private let network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
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

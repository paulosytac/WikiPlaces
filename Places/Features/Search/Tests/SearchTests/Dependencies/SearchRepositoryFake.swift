//
//  SearchRepositoryFake.swift
//  Search
//
//  Created by Paulo Correa on 01/10/2024.
//

import enum Network.NetworkError
import struct Network.NetworkRequest
import struct Search.Place
import protocol Search.SearchRepositoryProtocol
import Foundation

class SearchRepositoryFake: SearchRepositoryProtocol {
    var throwError: Bool = false
    
    func requestPlaces() async throws -> [Place] {
        if throwError {
            throw NetworkError.httpError(statusCode: 300)
        } else {
            places()
        }
    }
}

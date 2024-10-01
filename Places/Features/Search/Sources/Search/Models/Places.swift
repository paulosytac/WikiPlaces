//
//  Places.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Foundation
import protocol Network.NetworkResponse

public struct Places: NetworkResponse, Sendable {
    let places: [Place]
}

public struct Place: Codable, Hashable, Identifiable, Sendable {
    public var id: UUID
    let name: String
    let latitude, longitude: Double
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown Place"
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    public init (id: UUID = UUID(), name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Places {
    enum CodingKeys: String, CodingKey {
        case places = "locations"
    }
}

extension Place {
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}

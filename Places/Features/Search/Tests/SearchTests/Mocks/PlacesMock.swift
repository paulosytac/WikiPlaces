//
//  File.swift
//  Search
//
//  Created by Paulo Correa on 01/10/2024.
//

import Foundation
import struct Search.Place

public func places() -> [Place] {
    [
        Place(id: UUID(uuidString: "8B637283-1836-4998-9A3A-8253C65C24D9")!, name: "Amsterdam", latitude: 52.3676, longitude: 4.9041),
        Place(id: UUID(uuidString: "8B637283-1836-4998-9A3A-8253C65C24D9")!, name: "Rotterdam", latitude: 51.9244, longitude: 4.4777),
        Place(id: UUID(uuidString: "8B637283-1836-4998-9A3A-8253C65C24D9")!, name: "Porto Alegre", latitude: 30.0368, longitude: 51.2090)
    ]
}

public func placeQuery() -> [Place] {
    [
        Place(id: UUID(uuidString: "8B637283-1836-4998-9A3A-8253C65C24D9")!, name: "Porto Alegre", latitude: 30.0368, longitude: 51.2090)
    ]
}

//
//  DeeplinkFake.swift
//  Search
//
//  Created by Paulo Correa on 01/10/2024.
//

import protocol Deeplink.DeeplinkProtocol
import enum Deeplink.DeeplinkType
import Foundation

class DeeplinkFake: DeeplinkProtocol {
    var queryItems: [URLQueryItem]!
    var type: DeeplinkType!
    
    func openWiki(_ queryItems: [URLQueryItem], type: DeeplinkType) async {
        self.queryItems = queryItems
        self.type = type
    }
}

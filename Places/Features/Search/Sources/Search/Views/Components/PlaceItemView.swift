//
//  PlaceItemView.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import SwiftUI

struct PlaceItemView: View {
    private let place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(place.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .accessibilityLabel("\(Accessibility.placeNameLabel) \(place.name)")
            Text("\(Text.latitude) \(place.latitude)")
                .accessibilityLabel("\(Accessibility.latitudeLabel) \(place.latitude)")
            Text("\(Text.longitude) \(place.longitude)")
                .accessibilityLabel("\(Accessibility.longitudeLabel) \(place.longitude)")
        }
    }
}

// MARK: - Texts and Accessiblity
extension PlaceItemView {
    private enum Text {
        static let latitude = "Latitude:"
        static let longitude = "Longitude:"
    }
    
    private enum Accessibility {
        static let placeNameLabel = "Place name"
        static let latitudeLabel = "Latitude"
        static let longitudeLabel = "Longitude"
    }
}

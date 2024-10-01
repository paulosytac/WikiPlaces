//
//  CustomPlaceView.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Foundation
import SwiftUI

struct CustomPlaceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""

    var open: (Place) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField(Texts.name, text: $name)
                        .accessibilityLabel(Accessibility.nameLabel)
                        .accessibilityHint(Accessibility.nameHint)

                }
                Spacer()
                Button(Texts.openWiki) {
                    
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color.accentColor)
                .accessibilityLabel(Accessibility.openWikiLabel)
                .accessibilityHint(Accessibility.openWikiHint)
            }
            .navigationTitle(Texts.navigationTitle)
            .accessibilityElement(children: .contain)
            .toolbar(content: {
                Button(Texts.cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
                .accessibilityLabel(Accessibility.cancelLabel)
                .accessibilityHint(Accessibility.cancelHint)
            })
        }
    }
}

extension CustomPlaceView {
    private enum Texts {
        static let name = "Name"
        static let latitude = "Latitude"
        static let longitude = "Longitude"
        static let navigationTitle = "Custom Place"
        static let cancel = "Cancel"
        static let openWiki = "Open in Wikipedia"
    }
    
    private enum Accessibility {
        static let nameLabel = "Name input field"
        static let nameHint = "Enter a name for the custom place"
        static let latitudeLabel = "Latitude input field"
        static let latitudeHint = "Enter a latitude for the custom place"
        static let longitudeLabel = "Longitude input field"
        static let longitudeHint = "Enter a longitude for the custom place"
        static let openWikiLabel = "Open in Wikipedia"
        static let openWikiHint = "Tap to open the custom place in Wikipedia"
        static let cancelLabel = "Cancel"
        static let cancelHint = "Tap to dismiss the custom place view"
    }
}

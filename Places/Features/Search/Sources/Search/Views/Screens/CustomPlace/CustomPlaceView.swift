//
//  CustomPlaceView.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import Foundation
import SwiftUI
import struct Validator.PlaceLocationValidator

struct CustomPlaceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var showError: Bool = false
    @FocusState private var nameFocused: Bool
    @FocusState private var latitudeFocused: Bool
    @FocusState private var longitudeFocused: Bool

    var onDidEnterPlace: (Place) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section() {
                        TextField(Texts.name, text: $name)
                            .focused($nameFocused)
                            .onSubmit {
                                latitudeFocused = true
                            }
                            .submitLabel(.next)
                            .accessibilityLabel(Accessibility.nameLabel)
                            .accessibilityHint(Accessibility.nameHint)
                        
                        TextField(Texts.latitude, text: $latitude)
                            .focused($latitudeFocused)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel(Accessibility.nameLabel)
                            .accessibilityHint(Accessibility.nameHint)

                        TextField(Texts.longitude, text: $longitude)
                            .focused($longitudeFocused)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel(Accessibility.nameLabel)
                            .accessibilityHint(Accessibility.nameHint)
                    }
                }
                .toolbar {
                  ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: {
                        nameFocused = false
                        latitudeFocused = false
                        longitudeFocused = false
                    }) {
                        Text(Texts.done)
                            .accessibilityLabel(Accessibility.doneLabel)
                            .accessibilityHint(Accessibility.doneHint)
                    }
                    .accessibilityAction {
                        nameFocused = false
                        latitudeFocused = false
                        longitudeFocused = false
                    }
                  }
                }

                Button(action: openPlace) {
                    Text(Texts.openWiki)
                }
                .accessibilityAction {
                    openPlace()
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .accessibilityLabel(Accessibility.openWikiLabel)
                .accessibilityHint(Accessibility.openWikiHint)
                .disabled(name.isEmpty || latitude.isEmpty || longitude.isEmpty)
            }
            .navigationTitle(Texts.navigationTitle)
            .accessibilityElement(children: .contain)
            .toolbar(content: {
                Button(Texts.cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
                .accessibilityAction {
                    presentationMode.wrappedValue.dismiss()
                }
                .accessibilityLabel(Accessibility.cancelLabel)
                .accessibilityHint(Accessibility.cancelHint)
            })
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text(Texts.errorTitle),
                message: Text(Texts.error),
                dismissButton: .destructive(Text(Texts.done))
            )
        }
    }
    
    private func openPlace() {
        if let lat = Double(latitude),
            let long = Double(longitude),
            PlaceLocationValidator.isValidLatitude(latitude),
            PlaceLocationValidator.isValidLongitude(longitude) {
            onDidEnterPlace(
                Place(
                    name: name,
                    latitude: lat,
                    longitude: long
                )
            )
            presentationMode.wrappedValue.dismiss()
        } else {
            showError = true
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
        static let done = "Done"
        static let errorTitle = "Attention"
        static let error = "Check your coordinates"
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
        static let doneLabel = "Done"
        static let doneHint = "Tap to dismiss the keyboard"
        static let errorLabel = "Error"
    }
}

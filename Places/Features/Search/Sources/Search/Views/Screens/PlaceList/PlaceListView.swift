//
//  PlaceListView.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import DependencyContainer
import SwiftUI

public struct PlaceListView: View {
    @Injected private var viewModel: PlaceListViewModelProtocol
    @State private var searchQuery = ""
    @State private var isShowingCustomPlaceView = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                showLoading()
            case .loaded(let places):
                showList(places: places)
            case .error(let error):
                showError(error: error)
            }
        }
        .onAppear {
            requestPlaces()
        }
    }
}

// MARK: - Auxiliary Views
extension PlaceListView {
    private func showLoading() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(5.0, anchor: .center)
            .accessibilityLabel(Accessibility.loadingLabel)
    }
    
    private func showError(error: String) -> some View {
        VStack(alignment: .center, spacing: 20) {
            Text(Texts.error)
                .accessibilityLabel("\(Texts.error) \(error)")
            
            Button(Texts.retry) {
                requestPlaces()
            }
            .accessibilityAction {
                requestPlaces()
            }
            .accessibilityLabel(Accessibility.retryLabel)
            .accessibilityValue(Accessibility.retryValue)
        }
    }
    
    private func showList(places: [Place]) -> some View {
        VStack(spacing: 0) {
            List {
                ForEach(places, id: \.self) { place in
                    PlaceItemView(place: place)
                        .listRowSeparatorTint(.black)
                        .onTapGesture {
                            openPlace(place)
                        }
                        .accessibilityAction {
                            openPlace(place)
                        }
                }
            }
            .onEmpty(for: places.isEmpty, with: "\(Texts.notFound) \(searchQuery)")
            .searchable(
                text: $searchQuery,
                placement: .automatic,
                prompt: Texts.search
            )
            .textInputAutocapitalization(.never)
            .onChange(of: searchQuery) {
                searchPlaces(searchQuery)
            }
            .accessibilityElement(children: .combine)
            .accessibilityHint(Accessibility.listHint)
            .navigationTitle(Texts.navigationTitle)

            Button(Texts.customPlace) {
                isShowingCustomPlaceView.toggle()
            }
            .accessibilityAction {
                isShowingCustomPlaceView.toggle()
            }
            .font(.headline)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .accessibilityLabel(Accessibility.customPlaceLabel)
            .accessibilityHint(Accessibility.customPlaceHint)
        }
        .sheet(isPresented: $isShowingCustomPlaceView) {
            CustomPlaceView { place in
                openPlace(place)
            }
        }
    }
}

// MARK: - Helpers
extension PlaceListView {
    func requestPlaces() {
        Task {
            await viewModel.requestPlaces()
        }
    }
    
    func searchPlaces(_ searchQuery: String) {
        Task {
            await viewModel.searchPlaces(searchQuery)
        }
    }
    
    func openPlace(_ place: Place) {
        Task {
            await viewModel.openPlace(place)
        }
    }
}

// MARK: - Texts and Accessiblity
extension PlaceListView {
    private enum Texts {
        static let navigationTitle = "Places"
        static let error = "Something went wrong"
        static let retry = "Retry"
        static let notFound = "No places found for"
        static let search = "Search Places"
        static let customPlace = "Custom Place"
    }
    
    private enum Accessibility {
        static let loadingLabel = "Loading places"
        static let listHint = "Tap to select a place and open wiki page"
        static let retryLabel = "Retry searching"
        static let retryValue = "Retry"
        static let customPlaceLabel = "Enter a custom place"
        static let customPlaceHint = "Tap to enter a custom clace page"
    }
}

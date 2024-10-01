//
//  PlaceListView.swift
//  Search
//
//  Created by Paulo Correa on 29/09/2024.
//

import SwiftUI

public struct PlaceListView: View {
    @Environment(PlaceListViewModel.self) private var viewModel
    @State var searchQuery = ""
    
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
    }
}

// MARK: - Auxiliary Views
extension PlaceListView {
    private func showLoading() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(5.0, anchor: .center)
            .onAppear {
                requestPlaces()
            }
            .accessibilityLabel(Accessibility.loadingLabel)
    }
    
    private func showError(error: String) -> some View {
        VStack(alignment: .center, spacing: 20) {
            Text(Texts.error)
                .accessibilityLabel("\(Texts.error) \(error)")
            Button(Texts.retry) {
                requestPlaces()
            }
            .accessibilityLabel(Accessibility.retryLabel)
            .accessibilityValue(Accessibility.retryValue)
        }
    }
    
    private func showList(places: [Place]) -> some View {
        List {
            ForEach(places, id: \.self) { place in
                PlaceItemView(place: place)
                    .listRowSeparatorTint(.black)
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
            viewModel.searchPlaces(searchQuery)
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint(Accessibility.listHint)
        .navigationTitle(Texts.navigationTitle)
    }
}

// MARK: - Helpers
extension PlaceListView {
    func requestPlaces() {
        let vm = viewModel
        Task {
            await vm.requestPlaces()
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
    }
    
    private enum Accessibility {
        static let loadingLabel = "Loading places"
        static let listHint = "Tap to select a place and open wiki page"
        static let retryLabel = "Retry searching"
        static let retryValue = "Retry"
    }
}

#Preview {
    PlaceListView()
}

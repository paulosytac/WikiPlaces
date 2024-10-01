//
//  EmptyDataView.swift
//  Search
//
//  Created by Paulo Correa on 01/10/2024.
//

import SwiftUI

struct EmptyDataView: ViewModifier {
    let condition: Bool
    let message: String
    
    func body(content: Content) -> some View {
        validateView(content: content)
    }
    
    @ViewBuilder
    private func validateView(content: Content) -> some View {
        if condition {
            VStack(spacing: 20){
                Spacer()
                Image(systemName: Texts.emptySearchImage)
                    .accessibilityLabel(Accessibility.emptyImageLabel)
                    .scaleEffect(3)
                Text(message)
                    .font(.title)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(Accessibility.emptySearchLabel)
                    .accessibilityHint(Accessibility.searchHint)
                Spacer()
            }
        } else {
            content
        }
    }
}

extension View {
    func onEmpty(for condition: Bool, with message: String) -> some View {
        self.modifier(EmptyDataView(condition: condition, message: message))
    }
}

extension EmptyDataView {
    private enum Texts {
        static let emptySearchImage = "magnifyingglass"
    }
    
    private enum Accessibility {
        static let emptyImageLabel = "Magnifying glass icon"
        static let emptySearchLabel = "No results found"
        static let searchHint = "Refine your search by typing a different place"
    }
}

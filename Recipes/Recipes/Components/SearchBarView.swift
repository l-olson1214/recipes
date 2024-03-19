//
//  SearchBarView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/24/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.pastelPink)
                .padding(.leading, 8)
            TextField("Search", text: $searchText)
                .padding(.leading, 8)
                .focused($isTextFieldFocused)
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .onTapGesture {
            isSearching = true
            isTextFieldFocused = true
        }
    }
}

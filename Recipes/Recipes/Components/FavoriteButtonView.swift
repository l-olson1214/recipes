//
//  FavoriteButtonView.swift
//  Recipes
//
//  Created by Lindsey Olson on 3/18/24.
//

import SwiftUI

struct FavoriteButtonView: View {
    var dessert: Dessert
    var toggleFavorite: (_ dessert: Dessert) -> Void
    var isFavorite: (_ dessert: Dessert) -> Bool

    var body: some View {
        Button(action: {
            toggleFavorite(dessert)
        }, label: {
            Image(systemName: isFavorite(dessert) ? "heart.fill" : "heart")
                .foregroundColor(Color.pastelPink)
                .padding(8)
                .frame(width: 40, height: 40)
        })
        .focusable()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(dessert.title) Favorited: \(isFavorite(dessert).description)")
    }
}

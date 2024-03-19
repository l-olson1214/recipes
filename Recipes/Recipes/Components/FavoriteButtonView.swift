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
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: isFavorite(dessert) ? "heart.fill" : "heart")
                        .foregroundColor(Color.pastelPink)
                        .padding(8)
                )
                .padding(8)
                .shadow(radius: 5)
        })
    }
}

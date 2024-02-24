//
//  DessertDetailView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

struct DessertDetailView: View {
    var dessert: Dessert
    var viewModel: HomeViewModel
    @State private var dessertDetail: MealDetail?

    var body: some View {
        VStack {
            if let dessertDetail = dessertDetail {
                if let imageURL = URL(string: dessert.imageURL) {
                    AsyncImage(url: imageURL, scale: 5)
                }
                Text(dessertDetail.strMeal)
            } else {
                Text("Sorry, there has been an error fetching that dessert!")
            }
        }
        .onAppear {
            Task {
                do {
                    dessertDetail = try await viewModel.fetchMealDetail(byID: dessert.id)
                } catch {
                    print("Error fetching meal detail: \(error)")
                }
            }
        }
    }
}



//
//  DessertDetailView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

struct DessertDetailView: View {
    var dessert: Dessert
    var viewModel: DessertDetailViewModel
    var favoritesViewModel: FavoritesViewModel
    @State private var loadedDessertDetail: MealDetail?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageURL = URL(string: dessert.imageURL) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.pastelPink
                    }
                    .frame(height: UIScreen.main.bounds.height / 3.5)
                    .clipped()
                    .shadow(radius: 5)
                }
                
                if let dessertDetail = loadedDessertDetail {
                    dessertDetails(dessertDetail)
                } else {
                    ProgressView()
                }
                
                Spacer()
            }
        }
        .onAppear {
            Task {
                loadedDessertDetail = await viewModel.dessertDetail
            }
        }
    }
    
    private func dessertDetails(_ dessertDetail: MealDetail) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text(dessertDetail.strMeal)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                FavoriteButtonView(
                    dessert: dessert,
                    toggleFavorite: { dessert in
                        favoritesViewModel.toggleFavorite(dessert: dessert)
                    },
                    isFavorite: { dessert in
                        favoritesViewModel.isFavorite(dessert: dessert)
                    })
            }
            HStack {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .frame(width: 22)
                    .foregroundColor(Color.pastelPink)
                Text(dessertDetail.strArea)
                    .font(.callout)
            }
            ingredientsList(dessertDetail)
            instructions(dessertDetail)
        }
        .padding()
    }
    
    private func ingredientsList(_ dessertDetail: MealDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(viewModel.getIngredients(mealDetail: dessertDetail), id: \.self) { ingredient in
                HStack {
                    Image(systemName: "circle.fill")
                        .frame(height: 8)
                        .foregroundColor(Color.pastelPink)
                    Text(ingredient.measurement)
                    Text(ingredient.ingredient.capitalized)
                }
            }
        }
    }
    
    private func instructions(_ dessertDetail: MealDetail) -> some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.title2)
            Text(dessertDetail.strInstructions)
        }
    }
}

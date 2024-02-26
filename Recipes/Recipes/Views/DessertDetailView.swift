//
//  DessertDetailView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

struct DessertDetailView: View {
    var dessert: Dessert
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var dessertDetail: MealDetail?

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
                
                if let dessertDetail = dessertDetail {
                    dessertDetails(dessertDetail)
                } else {
                    Text("Sorry, there has been an error fetching the dessert details.")
                        .padding()
                }
                
                Spacer()
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
    
    private func dessertDetails(_ dessertDetail: MealDetail) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text(dessertDetail.strMeal)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
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
                    HStack {
                        Image(systemName: "circle.fill")
                            .frame(height: 8)
                            .foregroundColor(Color.pastelPink)
                        Text(ingredient.measurement)
                            .frame(width: 150, alignment: .leading)
                    }
                    Text(ingredient.ingredient.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
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

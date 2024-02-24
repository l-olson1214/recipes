//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    var dessertList: [Dessert] = []

    func fetchDesserts() async throws -> [Dessert] {
        let dessertManager = DessertManager()
        let dessertResponse = try await dessertManager.fetchDessert()
        return dessertResponse.desserts
    }

    func fetchMealDetail(byID id: String) async throws -> MealDetail {
        let mealDetailManager = MealDetailManager()
        let mealDetailResponse = try await mealDetailManager.fetchMealDetail(byID: id)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw NSError(domain: "No meal detail found", code: 0, userInfo: nil)
        }
        return mealDetail
    }

    func getNonNullIngredients(from mealDetail: MealDetail) -> [String] {
        var ingredients: [String] = []
        if let ingredient1 = mealDetail.strIngredient1, !ingredient1.isEmpty {
            ingredients.append(ingredient1)
        }
        if let ingredient2 = mealDetail.strIngredient2, !ingredient2.isEmpty {
            ingredients.append(ingredient2)
        }
        if let ingredient3 = mealDetail.strIngredient3, !ingredient3.isEmpty {
            ingredients.append(ingredient3)
        }
        if let ingredient4 = mealDetail.strIngredient4, !ingredient4.isEmpty {
            ingredients.append(ingredient4)
        }
        if let ingredient5 = mealDetail.strIngredient5, !ingredient5.isEmpty {
            ingredients.append(ingredient5)
        }
        if let ingredient6 = mealDetail.strIngredient6, !ingredient6.isEmpty {
            ingredients.append(ingredient6)
        }
        if let ingredient7 = mealDetail.strIngredient7, !ingredient7.isEmpty {
            ingredients.append(ingredient7)
        }
        if let ingredient8 = mealDetail.strIngredient8, !ingredient8.isEmpty {
            ingredients.append(ingredient8)
        }
        if let ingredient9 = mealDetail.strIngredient9, !ingredient9.isEmpty {
            ingredients.append(ingredient9)
        }
        if let ingredient10 = mealDetail.strIngredient10, !ingredient10.isEmpty {
            ingredients.append(ingredient10)
        }
        if let ingredient11 = mealDetail.strIngredient11, !ingredient11.isEmpty {
            ingredients.append(ingredient11)
        }
        if let ingredient12 = mealDetail.strIngredient12, !ingredient12.isEmpty {
            ingredients.append(ingredient12)
        }
        if let ingredient13 = mealDetail.strIngredient13, !ingredient13.isEmpty {
            ingredients.append(ingredient13)
        }
        if let ingredient14 = mealDetail.strIngredient14, !ingredient14.isEmpty {
            ingredients.append(ingredient14)
        }
        if let ingredient15 = mealDetail.strIngredient15, !ingredient15.isEmpty {
            ingredients.append(ingredient15)
        }
        if let ingredient16 = mealDetail.strIngredient16, !ingredient16.isEmpty {
            ingredients.append(ingredient16)
        }
        if let ingredient17 = mealDetail.strIngredient17, !ingredient17.isEmpty {
            ingredients.append(ingredient17)
        }
        if let ingredient18 = mealDetail.strIngredient18, !ingredient18.isEmpty {
            ingredients.append(ingredient18)
        }
        if let ingredient19 = mealDetail.strIngredient19, !ingredient19.isEmpty {
            ingredients.append(ingredient19)
        }
        if let ingredient20 = mealDetail.strIngredient20, !ingredient20.isEmpty {
            ingredients.append(ingredient20)
        }
        return ingredients
    }

    func getNonNullMeasures(from mealDetail: MealDetail) -> [String] {
        var measures: [String] = []
        if let measure1 = mealDetail.strMeasure1, !measure1.isEmpty {
            measures.append(measure1)
        }
        if let measure2 = mealDetail.strMeasure2, !measure2.isEmpty {
            measures.append(measure2)
        }
        if let measure3 = mealDetail.strMeasure3, !measure3.isEmpty {
            measures.append(measure3)
        }
        if let measure4 = mealDetail.strMeasure4, !measure4.isEmpty {
            measures.append(measure4)
        }
        if let measure5 = mealDetail.strMeasure5, !measure5.isEmpty {
            measures.append(measure5)
        }
        if let measure6 = mealDetail.strMeasure6, !measure6.isEmpty {
            measures.append(measure6)
        }
        if let measure7 = mealDetail.strMeasure7, !measure7.isEmpty {
            measures.append(measure7)
        }
        if let measure8 = mealDetail.strMeasure8, !measure8.isEmpty {
            measures.append(measure8)
        }
        if let measure9 = mealDetail.strMeasure9, !measure9.isEmpty {
            measures.append(measure9)
        }
        if let measure10 = mealDetail.strMeasure10, !measure10.isEmpty {
            measures.append(measure10)
        }
        if let measure11 = mealDetail.strMeasure11, !measure11.isEmpty {
            measures.append(measure11)
        }
        if let measure12 = mealDetail.strMeasure12, !measure12.isEmpty {
            measures.append(measure12)
        }
        if let measure13 = mealDetail.strMeasure13, !measure13.isEmpty {
            measures.append(measure13)
        }
        if let measure14 = mealDetail.strMeasure14, !measure14.isEmpty {
            measures.append(measure14)
        }
        if let measure15 = mealDetail.strMeasure15, !measure15.isEmpty {
            measures.append(measure15)
        }
        if let measure16 = mealDetail.strMeasure16, !measure16.isEmpty {
            measures.append(measure16)
        }
        if let measure17 = mealDetail.strMeasure17, !measure17.isEmpty {
            measures.append(measure17)
        }
        if let measure18 = mealDetail.strMeasure18, !measure18.isEmpty {
            measures.append(measure18)
        }
        if let measure19 = mealDetail.strMeasure19, !measure19.isEmpty {
            measures.append(measure19)
        }
        if let measure20 = mealDetail.strMeasure20, !measure20.isEmpty {
            measures.append(measure20)
        }
        return measures
    }

    func getIngredients(mealDetail: MealDetail) -> [Ingredient] {
        let measurements = getNonNullMeasures(from: mealDetail)
        let ingredients = getNonNullIngredients(from: mealDetail)
        var ingredientPairs: [Ingredient] = []
        
        let count = min(measurements.count, ingredients.count)
        
        for i in 0..<count {
            let measurement = measurements[i]
            let ingredient = ingredients[i]
            
            if !measurement.isEmpty && !ingredient.isEmpty {
                let ingredientPair = Ingredient(measurement: measurement, ingredient: ingredient)
                ingredientPairs.append(ingredientPair)
            }
        }
        
        return ingredientPairs
    }
}


// MARK: - Ingredient Struct

struct Ingredient: Hashable {
    var measurement: String
    var ingredient: String
}

//
//  DessertDetails.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

class MealDetailManager {
    func fetchMealDetail(byID id: String) async throws -> MealDetailResponse {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MealDetailResponse.self, from: data)
    }
}


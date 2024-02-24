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
}

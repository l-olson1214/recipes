//
//  DessertDetailViewModel.swift
//  Recipes
//
//  Created by Lindsey Olson on 3/18/24.
//

import CoreData
import Foundation

class DessertDetailViewModel: ObservableObject {
    let networkManager: NetworkRepository
    let id: String
    var dessertDetail: MealDetail? {
        get async {
            do {
                return try await fetchMealDetail(byID: id)
            } catch {
                print("Error fetching meal detail")
                return nil
            }
        }
    }

    init(networkManager: NetworkRepository, id: String) {
        self.networkManager = networkManager
        self.id = id
    }
    
    func fetchMealDetail(byID id: String) async throws -> MealDetail {
        let mealDetailResponse = try await networkManager.fetchMealDetail(byID: id)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw NSError(domain: "No meal detail found", code: 0, userInfo: nil)
        }
        return mealDetail
    }
    
    // MARK: - Ingredients
    func getNonNullIngredients(from mealDetail: MealDetail) -> [String] {
        return [
            mealDetail.strIngredient1,
            mealDetail.strIngredient2,
            mealDetail.strIngredient3,
            mealDetail.strIngredient4,
            mealDetail.strIngredient5,
            mealDetail.strIngredient6,
            mealDetail.strIngredient7,
            mealDetail.strIngredient8,
            mealDetail.strIngredient9,
            mealDetail.strIngredient10,
            mealDetail.strIngredient11,
            mealDetail.strIngredient12,
            mealDetail.strIngredient13,
            mealDetail.strIngredient14,
            mealDetail.strIngredient15,
            mealDetail.strIngredient16,
            mealDetail.strIngredient17,
            mealDetail.strIngredient18,
            mealDetail.strIngredient19,
            mealDetail.strIngredient20,
        ].compactMap { $0 }
            .filter{ !$0.isEmpty }
    }

    // MARK: - Measurements
    func getNonNullMeasures(from mealDetail: MealDetail) -> [String] {
        return [
            mealDetail.strMeasure1,
            mealDetail.strMeasure2,
            mealDetail.strMeasure3,
            mealDetail.strMeasure4,
            mealDetail.strMeasure5,
            mealDetail.strMeasure6,
            mealDetail.strMeasure7,
            mealDetail.strMeasure8,
            mealDetail.strMeasure9,
            mealDetail.strMeasure10,
            mealDetail.strMeasure11,
            mealDetail.strMeasure12,
            mealDetail.strMeasure13,
            mealDetail.strMeasure14,
            mealDetail.strMeasure15,
            mealDetail.strMeasure16,
            mealDetail.strMeasure17,
            mealDetail.strMeasure18,
            mealDetail.strMeasure19,
            mealDetail.strMeasure20,
        ].compactMap { $0 }
          .filter { !$0.isEmpty }
    }

    // MARK: - Measurements + Ingredients done
    
    func getIngredients(mealDetail: MealDetail) -> [Ingredient] {
        let measurements = getNonNullMeasures(from: mealDetail)
        let ingredients = getNonNullIngredients(from: mealDetail)

        return zip(measurements, ingredients).map {
            let (measurement, ingredient) = $0
            return Ingredient(measurement: measurement, ingredient: ingredient)
        }
    }
}

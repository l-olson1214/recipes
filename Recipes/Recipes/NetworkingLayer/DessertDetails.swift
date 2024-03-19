//
//  DessertDetails.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

import Foundation

class NetworkRepository {
    private var cache: [URL: Data] = [:]

    func fetchMealDetail(byID id: String) async throws -> MealDetailResponse {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        let url = URL(string: urlString)!

        if let cachedData = cache[url] {
            return try JSONDecoder().decode(MealDetailResponse.self, from: cachedData)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        cache[url] = data
        return try JSONDecoder().decode(MealDetailResponse.self, from: data)
    }

    func fetchDessert() async throws -> DessertResponse {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        let url = URL(string: urlString)!

        if let cachedData = cache[url] {
            return try JSONDecoder().decode(DessertResponse.self, from: cachedData)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        cache[url] = data
        return try JSONDecoder().decode(DessertResponse.self, from: data)
    }
}

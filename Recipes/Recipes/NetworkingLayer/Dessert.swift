//
//  Dessert.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

// MARK: - Structs for Dessert

struct Dessert: Codable, Identifiable, Hashable {
    let title: String
    let imageURL: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case title = "strMeal"
        case imageURL = "strMealThumb"
        case id = "idMeal"
    }
}

struct DessertResponse: Codable {
    let desserts: [Dessert]

    enum CodingKeys: String, CodingKey {
        case desserts = "meals"
    }
}

class DessertManager {
    func fetchDessert() async throws -> DessertResponse {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DessertResponse.self, from: data)
    }
}

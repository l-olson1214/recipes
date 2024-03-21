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
    let imageURL: String?
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

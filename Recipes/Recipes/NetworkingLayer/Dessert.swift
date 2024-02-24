//
//  Dessert.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

// MARK: - Structs for Dessert

struct Dessert: Codable, Identifiable {
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
    func fetchDessert(completion: @escaping (Result<DessertResponse, Error>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let dessertResponse = try JSONDecoder().decode(DessertResponse.self, from: data)
                completion(.success(dessertResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

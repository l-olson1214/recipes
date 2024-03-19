//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import CoreData
import Foundation

class HomeViewModel: ObservableObject {
    var dessertList: [Dessert] = []
    let networkManager: NetworkRepository
    
    init(networkManager: NetworkRepository) {
        self.networkManager = networkManager
    }

    func fetchDesserts() async throws -> [Dessert] {
        let dessertResponse = try await networkManager.fetchDessert()
        return dessertResponse.desserts
    }
}

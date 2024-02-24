//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    var dessertList: [Dessert] = []

    func fetchDessert(completion: @escaping (Error?) -> Void) {
        let dessertManager = DessertManager()
        dessertManager.fetchDessert { result in 
            switch result {
            case .success(let dessertResponse):
                self.dessertList = dessertResponse.desserts
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

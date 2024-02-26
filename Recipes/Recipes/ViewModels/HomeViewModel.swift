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
    @Published var favorites: [Dessert] = []
    let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService = CoreDataService.shared) {
        self.coreDataService = coreDataService
        self.favorites = loadFavorites()
    }
    
    func loadFavorites() -> [Dessert] {
        let context = coreDataService.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteDessert> = FavoriteDessert.fetchRequest()
        
        do {
            let favoriteDesserts = try context.fetch(fetchRequest)
            let favorites = favoriteDesserts.map { favoriteDessert in
                let id = favoriteDessert.id
                let name = favoriteDessert.name
                let imageURL = favoriteDessert.imageURL ?? ""
                return Dessert(title: name, imageURL: imageURL, id: id)
            }
            return favorites
        } catch {
            fatalError("Error loading favorites: \(error)")
        }
    }
    
    func toggleFavorite(dessert: Dessert) {
        let context = coreDataService.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteDessert> = FavoriteDessert.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", dessert.id)
        
        do {
            if let existingFavorite = try context.fetch(fetchRequest).first {
                context.delete(existingFavorite)
                favorites.removeAll { $0.id == dessert.id }
            } else {
                let newFavorite = FavoriteDessert(context: context)
                newFavorite.id = dessert.id
                newFavorite.name = dessert.title
                newFavorite.imageURL = dessert.imageURL
                favorites.append(dessert)
            }
            coreDataService.saveContext()
        } catch {
            fatalError("Error toggling favorite: \(error)")
        }
    }

    
    func isFavorite(dessert: Dessert) -> Bool {
        let dessertID = dessert.id
        
        return favorites.contains { $0.id == dessertID }
    }
    
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


// MARK: - Ingredient Struct

struct Ingredient: Hashable {
    var measurement: String
    var ingredient: String
}

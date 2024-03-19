//
//  FavoritesViewModel.swift
//  Recipes
//
//  Created by Lindsey Olson on 3/18/24.
//

import Foundation

import CoreData
import Foundation

class FavoritesViewModel: ObservableObject {
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
}

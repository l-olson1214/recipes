//
//  FavoriteDessert+CoreDataProperties.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/25/24.
//
//

import Foundation
import CoreData


extension FavoriteDessert {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteDessert> {
        return NSFetchRequest<FavoriteDessert>(entityName: "FavoriteDessert")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var imageURL: String?

}

extension FavoriteDessert : Identifiable {

}

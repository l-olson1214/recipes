//
//  RecipesApp.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .tint(Color.pastelPink)
        }
    }
}

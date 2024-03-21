//
//  RecipesApp.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject private var viewModel = HomeViewModel(networkManager: NetworkRepository())
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var isFavorites = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView(selection: $isFavorites) {
                    HomeView(isFavorites: false)
                        .environmentObject(viewModel)
                        .environmentObject(favoritesViewModel)
                        .tag(false)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }

                    HomeView(isFavorites: true)
                        .environmentObject(viewModel)
                        .environmentObject(favoritesViewModel)
                        .tag(true)
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Favorites")
                        }
                }
                .tabViewStyle(.automatic)
            }
            .tint(Color.pastelPink)
        }
    }
}

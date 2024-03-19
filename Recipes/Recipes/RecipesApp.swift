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

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(viewModel)
            }
            .tint(Color.pastelPink)
        }
    }
}

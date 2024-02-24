//
//  HomeView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import SwiftUI

struct HomeView: View {
    var viewModel = HomeViewModel()
    @State var dessert: [Dessert] = []

    var body: some View {
        VStack {
            Text("Desserts")
            List(dessert) { dessert in
                Text(dessert.title)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDessert { error in
                if let error = error {
                    print("Error fetching meals: \(error)")
                } else {
                    dessert = viewModel.dessertList
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

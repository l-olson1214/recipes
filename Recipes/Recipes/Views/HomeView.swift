//
//  HomeView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/23/24.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State var dessert: [Dessert] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isFavorites: Bool = false
    @State private var isLoading: Bool = true
    private var filteredDessertList: [Dessert] {
        if isFavorites {
            return filteredDesserts(list: favoritesViewModel.favorites)
        } else {
            return filteredDesserts(list: dessert)
        }
    }
    
    public init(isFavorites: Bool = false) {
        _isFavorites = State(initialValue: isFavorites)
    }
    
    @FetchRequest(
        entity: FavoriteDessert.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "id != nil")
    ) var favorites: FetchedResults<FavoriteDessert>
    
    var body: some View {
        VStack(spacing: 16) {
            header

            SearchBarView(searchText: $searchText, isSearching: $isSearching)

            if isLoading {
                ProgressView()
                Spacer()
            } else {
                dessertList
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    dessert = try await viewModel.fetchDesserts()
                    isLoading = false
                } catch {
                    print("Error fetching desserts: \(error)")
                }
            }
        }
    }

    private var header: some View {
        Text(isFavorites ? "Favorites" : "Desserts")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.pastelPink)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityLabel(Text("\(isFavorites ? "Favorites" : "Desserts") : Header"))
    }
    
    private func filteredDesserts(list: [Dessert]) -> [Dessert] {
        if searchText.isEmpty {
            return list
        } else {
            return list.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    private var dessertList: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                if filteredDessertList.isEmpty {
                    Text("Sorry, no desserts could be found.")
                } else {
                    ForEach(filteredDessertList, id: \.id) { dessert in
                        DessertItemView(
                            dessert: dessert,
                            viewModel: viewModel,
                            favoritesViewModel: favoritesViewModel
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(isFavorites: false)
}

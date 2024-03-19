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
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @State var dessert: [Dessert] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isFavorites = false
    @State private var isLoading: Bool = true
    
    @FetchRequest(
        entity: FavoriteDessert.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "id != nil")
    ) var favorites: FetchedResults<FavoriteDessert>
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(isFavorites ? "Favorites" : "Desserts")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pastelPink)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button {
                    isFavorites.toggle()
                } label: {
                    HStack {
                        Text(isFavorites ? "Home" : "Favorites")
                        Image(systemName: isFavorites ? "house.fill" : "heart.fill")
                            .foregroundColor(Color.pastelPink)
                            .padding(8)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
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
    
    private func filteredDesserts(list: [Dessert]) -> [Dessert] {
        if searchText.isEmpty {
            return list
        } else {
            return list.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private var dessertList: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(isFavorites ? filteredDesserts(list: favoritesViewModel.favorites) : filteredDesserts(list: dessert), id: \.id) { dessert in
                    NavigationLink(
                        destination: DessertDetailView(
                            dessert: dessert,
                            viewModel: DessertDetailViewModel(
                                networkManager: viewModel.networkManager,
                                id: dessert.id),
                            favoritesViewModel: favoritesViewModel))
                        {
                        ZStack(alignment: .topTrailing) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 5, y: 5)
                            
                            dessertImage(url: dessert.imageURL, title: dessert.title)
                            favoritesButton(dessert: dessert)
                        }
                    }
                }
            }
        }
    }
    private func dessertImage(url: String, title: String) -> some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .clipped()
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 10
                        )
                    )
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
            }
            
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.pastelPink)
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(width: 24)
                    .foregroundColor(Color.pastelPink)
            }
            .padding()
        }
    }
    
    private func favoritesButton(dessert: Dessert) -> some View {
        FavoriteButtonView(
            dessert: dessert,
            toggleFavorite: { dessert in
                favoritesViewModel.toggleFavorite(dessert: dessert)
            },
            isFavorite: { dessert in
                favoritesViewModel.isFavorite(dessert: dessert)
            })
    }
}

#Preview {
    HomeView()
}

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
    @State var dessert: [Dessert] = []
    @State var details: MealDetail? = nil
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isFavorites = false
    
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
                    .frame(maxWidth: .infinity)

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
            dessertList
                
        }
        .padding()
        .onAppear {
            Task {
                do {
                    dessert = try await viewModel.fetchDesserts()
                } catch {
                    print("Error fetching desserts: \(error)")
                }
            }
        }
    }
    
    private var filteredDesserts: [Dessert] {
        if searchText.isEmpty {
            return dessert
        } else {
            return dessert.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private var dessertList: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(isFavorites ? viewModel.favorites : filteredDesserts, id: \.id) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert)
                        .environmentObject(viewModel)
                    ) {
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
                Color.pastelPink
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .clipped()
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
        Button(action: {
            viewModel.toggleFavorite(dessert: dessert)
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: viewModel.isFavorite(dessert: dessert) ? "heart.fill" : "heart")
                        .foregroundColor(Color.pastelPink)
                        .padding(8)
                )
                .padding(8)
                .shadow(radius: 5)
        })
    }
}

#Preview {
    HomeView()
}

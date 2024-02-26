//
//  FavoritesView.swift
//  Recipes
//
//  Created by Lindsey Olson on 2/25/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text("Favorites")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.pastelPink)
            favoritesList
        }
        .padding()
    }
    
    private var favoritesList: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach($viewModel.favorites.wrappedValue, id: \.id) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert, viewModel: viewModel)) {
                        ZStack(alignment: .topTrailing) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 5, y: 5)
                            
                            dessertImage(url: dessert.imageURL, title: dessert.title)
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
}

#Preview {
    FavoritesView(viewModel: HomeViewModel())
}

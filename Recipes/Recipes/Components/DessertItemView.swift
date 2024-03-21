//
//  DessertItemView.swift
//  Recipes
//
//  Created by Lindsey Olson on 3/19/24.
//

import SwiftUI

struct DessertItemView: View {
    let dessert: Dessert
    @StateObject var viewModel: HomeViewModel
    @StateObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 10, y: 5)
            HStack(alignment: .top) {
                NavigationLink(
                    destination: DessertDetailView(
                        dessert: dessert,
                        viewModel: DessertDetailViewModel(
                            networkManager: viewModel.networkManager,
                            id: dessert.id),
                        favoritesViewModel: favoritesViewModel))
                {
                    dessertInfo(url: dessert.imageURL, title: dessert.title)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(Text("\(dessert.title) - navigate to detail page"))
                }
                favoritesButton(dessert: dessert)
            }
        }
    }
    
    private func dessertInfo(url: String, title: String) -> some View {
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
            }
        )
    }
}

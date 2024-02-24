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
    @State var details: MealDetail? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Desserts")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                ForEach(dessert, id: \.id) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert, viewModel: viewModel)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                            VStack(spacing: 0) {
                                AsyncImage(url: URL(string: dessert.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150)
                                        .clipped()
                                } placeholder: {
                                    Color.gray
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150)
                                        .clipped()
                                }
                                
                                Text(dessert.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(16)
                        }
                    }
                }
            }
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
}

#Preview {
    HomeView()
}

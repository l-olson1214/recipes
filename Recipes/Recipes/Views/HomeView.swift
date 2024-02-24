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
                .foregroundColor(Color.pastelPink)
            
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
    
    private var dessertList: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(dessert, id: \.id) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert, viewModel: viewModel)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.07), radius: 10, x: 5, y: 5)
                            
                            VStack(spacing: 0) {
                                AsyncImage(url: URL(string: dessert.imageURL)) { image in
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
                                    Text(dessert.title)
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
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

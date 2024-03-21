//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Lindsey Olson on 2/23/24.
//

import XCTest
@testable import Recipes

final class RecipesTests: XCTestCase {
    var viewModel: HomeViewModel!
    var favoritesViewModel: FavoritesViewModel!
    var dessertViewModel: DessertDetailViewModel!
    
    var networkManager = NetworkRepository()
    
    let mealDetail = MealDetail(
        idMeal: "1",
        strMeal: "Test Meal",
        strDrinkAlternate: nil,
        strCategory: "Test Category",
        strArea: "Test Area",
        strInstructions: "Test Instructions",
        strMealThumb: "Test Thumb",
        strTags: nil,
        strYoutube: "Test Youtube",
        strIngredient1: "Ingredient 1",
        strIngredient2: "Ingredient 2",
        strIngredient3: nil,
        strIngredient4: nil,
        strIngredient5: nil,
        strIngredient6: nil,
        strIngredient7: nil,
        strIngredient8: nil,
        strIngredient9: nil,
        strIngredient10: nil,
        strIngredient11: nil,
        strIngredient12: nil,
        strIngredient13: nil,
        strIngredient14: nil,
        strIngredient15: nil,
        strIngredient16: nil,
        strIngredient17: nil,
        strIngredient18: nil,
        strIngredient19: nil,
        strIngredient20: nil,
        strMeasure1: "Measure 1",
        strMeasure2: "Measure 2",
        strMeasure3: nil,
        strMeasure4: nil,
        strMeasure5: nil,
        strMeasure6: nil,
        strMeasure7: nil,
        strMeasure8: nil,
        strMeasure9: nil,
        strMeasure10: nil,
        strMeasure11: nil,
        strMeasure12: nil,
        strMeasure13: nil,
        strMeasure14: nil,
        strMeasure15: nil,
        strMeasure16: nil,
        strMeasure17: nil,
        strMeasure18: nil,
        strMeasure19: nil,
        strMeasure20: nil,
        strSource: nil,
        strImageSource: nil,
        strCreativeCommonsConfirmed: nil,
        dateModified: nil
    )
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(networkManager: networkManager)
        favoritesViewModel = FavoritesViewModel()
        dessertViewModel = DessertDetailViewModel(networkManager: networkManager, id: "")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetNonNullIngredients() {
        // Given mealdetail
        
        // When
        let ingredients = dessertViewModel.getNonNullIngredients(from: mealDetail)
        
        // Then
        XCTAssertEqual(ingredients, [
            "Ingredient 1",
            "Ingredient 2"
        ])
    }
    
    func testGetNonNullMeasures() {
        // Given mealdetail
        
        // When
        let measures = dessertViewModel.getNonNullMeasures(from: mealDetail)
        
        // Then
        XCTAssertEqual(measures, [
            "Measure 1",
            "Measure 2"
        ])
    }
    
    func testGetIngredients() {
        // Given meal detail
        
        // When
        let ingredients = dessertViewModel.getIngredients(mealDetail: mealDetail)

        // Then
        XCTAssertEqual(ingredients, [
            Ingredient(measurement: "Measure 1", ingredient: "Ingredient 1"),
            Ingredient(measurement: "Measure 2", ingredient: "Ingredient 2")
        ])
    }
}


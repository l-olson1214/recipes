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
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(networkManager: NetworkRepository())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchDesserts() {
        let expectation = XCTestExpectation(description: "Fetch desserts")

        let networkManager = NetworkRepository()
        Task {
            do {
                let dessertResponse = try await networkManager.fetchDessert()
                XCTAssertFalse(dessertResponse.desserts.isEmpty, "Dessert list should not be empty")
                expectation.fulfill()
            } catch {
                XCTFail("Failed to fetch desserts with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchMealDetail() {
        let expectation = XCTestExpectation(description: "Fetch meal detail")
        
        let networkManager = NetworkRepository()
        Task {
            do {
                let mealDetailResponse = try await networkManager.fetchMealDetail(byID: "52767")
                guard let mealDetail = mealDetailResponse.meals.first else {
                    XCTFail("No meal detail found")
                    return
                }
                XCTAssertNotNil(mealDetail, "Meal detail should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Failed to fetch meal detail with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}


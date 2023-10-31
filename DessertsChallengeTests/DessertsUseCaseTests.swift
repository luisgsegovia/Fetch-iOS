//
//  DessertsUseCaseTests.swift
//  DessertsTestTests
//
//  Created by Luis Segovia on 29/10/23.
//

import XCTest
import Combine
import Foundation
@testable import DessertsChallenge

final class DessertsUseCaseTests: XCTestCase {
    var mockAPIClient: APIMealServiceProtocol!
    var suscriptions = Set<AnyCancellable>()

    override func setUp() {
        mockAPIClient = MockAPIClient()
    }

    func test_dessertsUseCase_returnsValidUIModel() {
        let sut = DessertsUseCase(apiClient: mockAPIClient)

        sut.retrieveDesserts()
            .sink(receiveCompletion: {_ in }, receiveValue: { result in
                XCTAssertEqual(result.count, 1)
                XCTAssertEqual(result.first?.name, "Test")
                XCTAssertEqual(result.first?.thumbnailURL, "urlTest")
                XCTAssertEqual(result.first?.id, "idTest")
            })
            .store(in: &suscriptions)
    }

    func test_dessertDetailUseCase_returnsValidUIModel() {
        let sut = DessertsUseCase(apiClient: mockAPIClient)

        sut.retrieveDessertDetail(id: "8088")
            .sink(receiveCompletion: {_ in }, receiveValue: { result in
                XCTAssertEqual(result.name, "testMeal")
                XCTAssertEqual(result.instructions, "")
                XCTAssertEqual(result.ingredients.count, 1)
                XCTAssertEqual(result.ingredients["Cup"], "One")
            })
            .store(in: &suscriptions)
    }
}

private struct MockAPIClient: APIMealServiceProtocol {
    func retrieveMeals() -> AnyPublisher<MealCategoryResponse, Error> {
        return Just(
            MealCategoryResponse(
                meals: [.init(strMeal: "Test", strMealThumb: "urlTest", idMeal: "idTest")]
            )
        )
        .mapError { _ in NSError(domain: "", code: 0) }
        .eraseToAnyPublisher()
    }

    func retrieveMealDetail(with code: String) -> AnyPublisher<MealDetailResponse, Error> {
        return Just(
            MealDetailResponse(
                meals: [.init(idMeal: "", strMeal: "testMeal", strDrinkAlternate: "", strCategory: "", strArea: "", strInstructions: "", strMealThumb: "", strTags: "", strYoutube: "", strIngredient1: "Cup", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "One", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")]
            )
        )
        .mapError { _ in NSError(domain: "", code: 0) }
        .eraseToAnyPublisher()
    }
}

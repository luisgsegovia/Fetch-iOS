//
//  DessertsUIDataMapper.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

enum DessertsUIDataMapper {
    static func mapToDessertsModel(_ response: [MealInformation]) -> [DessertItem] {
        response.map { DessertItem(id: $0.idMeal, name: $0.strMeal, thumbnailURL: $0.strMealThumb) }.sorted()
    }

    static func mapToDessertDetailModel(_ response: MealDetailResponse) -> DessertDetailUIModel {
        guard let dessertDetail = response.meals.first else {
            return .init(name: "", instructions: "", imageURL: "", ingredients: [:])
        }
        return .init(
            name: dessertDetail.strMeal ?? "",
            instructions: dessertDetail.strInstructions ?? "",
            imageURL: dessertDetail.strMealThumb ?? "",
            ingredients: dessertDetail.ingredients)
    }
}

//
//  MealCategoryResponse.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

struct MealCategoryResponse: Decodable, Equatable {
    let meals: [MealInformation]
}

struct MealInformation: Decodable, Equatable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}


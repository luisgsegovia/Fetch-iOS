//
//  APIService.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import Foundation
import Combine

protocol APIMealServiceProtocol: APIServiceProtocol {
    func retrieveMeals() -> AnyPublisher<MealCategoryResponse, Error>
    func retrieveMealDetail(with code: String) -> AnyPublisher<MealDetailResponse, Error>
}

final class APIService: APIMealServiceProtocol {
    let baseURL = "https://themealdb.com/"

    func retrieveMeals() -> AnyPublisher<MealCategoryResponse, Error> {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path = "/api/json/v1/1/filter.php"
        urlComponents.queryItems = [
            .init(name: "c", value: "Dessert")
        ]

        let urlRequest = URLRequest(url: urlComponents.url!)

        return make(urlRequest)
    }

    func retrieveMealDetail(with code: String) -> AnyPublisher<MealDetailResponse, Error> {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path = "/api/json/v1/1/lookup.php"
        urlComponents.queryItems = [
            .init(name: "i", value: code)
        ]

        let urlRequest = URLRequest(url: urlComponents.url!)

        return make(urlRequest)
    }

}

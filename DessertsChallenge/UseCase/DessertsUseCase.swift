//
//  DessertsUseCase.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import Combine

protocol DessertsUseCaseProtocol {
    func retrieveDesserts() -> AnyPublisher<[DessertItem], DessertError>
    func retrieveDessertDetail(id: String) -> AnyPublisher<DessertDetailUIModel, DessertError>
}

struct DessertsUseCase: DessertsUseCaseProtocol {
    let apiClient: APIMealServiceProtocol

    func retrieveDesserts() -> AnyPublisher<[DessertItem], DessertError> {
        apiClient.retrieveMeals()
            .mapError { _ in return .error }
            .map(\.meals)
            .map(DessertsUIDataMapper.mapToDessertsModel)
            .eraseToAnyPublisher()
    }

    func retrieveDessertDetail(id: String) -> AnyPublisher<DessertDetailUIModel, DessertError> {
        apiClient.retrieveMealDetail(with: id)
            .mapError { _ in return .error }
            .map(DessertsUIDataMapper.mapToDessertDetailModel)
            .eraseToAnyPublisher()
    }
}

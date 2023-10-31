//
//  MockDessertsUseCase.swift
//  DessertsChallengeTests
//
//  Created by Luis Segovia on 31/10/23.
//

import Combine
@testable import DessertsChallenge

class MockDessertsUseCase: DessertsUseCaseProtocol {
    var dessertsPublisherResult: AnyPublisher<[DessertItem], DessertError>?
    var dessertDetailPublisherResult: AnyPublisher<DessertDetailUIModel, DessertError>?

    func retrieveDesserts() -> AnyPublisher<[DessertItem], DessertError> {
        guard let publisher = dessertsPublisherResult else {
            fatalError("No result given")
        }
        return publisher
    }

    func retrieveDessertDetail(id: String) -> AnyPublisher<DessertDetailUIModel, DessertError> {
        guard let publisher = dessertDetailPublisherResult else {
            fatalError("No result given")
        }
        return publisher
    }


}

//
//  DessertsViewModelTests.swift
//  DessertsChallengeTests
//
//  Created by Luis Segovia on 31/10/23.
//

import Combine
import XCTest
@testable import DessertsChallenge

final class DessertsViewModelTests: XCTestCase {
    private var useCase: MockDessertsUseCase!
    private var subscriptions = Set<AnyCancellable>()
    private var sut: DessertsViewModel!

    override func setUp() {
        super.setUp()
        useCase = MockDessertsUseCase()
        sut = DessertsViewModel(useCase: useCase)
    }

    override func tearDown() {
        super.tearDown()
        subscriptions = []
        useCase = nil
        sut = nil
    }

    func test_initialState() {
        XCTAssertEqual(sut.uiState, .loading)
    }

    func test_getDesserts_finishesSuccessfully() {
        let dessertItem = DessertItem(id: "", name: "", thumbnailURL: "")
        useCase.dessertsPublisherResult =
        Just([dessertItem])
            .mapError {_ in return DessertError.error }
            .eraseToAnyPublisher()

        let exp = expectation(description: "Waiting for UI states...")
        match(uiStates: [.loading, .idle([dessertItem])]) {
            exp.fulfill()
        }

        sut.refresh()
        wait(for: [exp], timeout: 1)

    }

    // Error scenarios can be added later

    private func match(uiStates: [DessertsViewModel.State], finished: @escaping () -> Void) {
        var states = uiStates
        sut.$uiState
            .sink(receiveValue: { state in
                if let expectedState = states.first {
                    states.remove(at: .zero)
                    XCTAssertEqual(state, expectedState)
                }
                if states.isEmpty {
                    finished()
                }
            })
            .store(in: &subscriptions)
    }
}

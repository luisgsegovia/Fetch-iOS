//
//  DessertDetailViewModel.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import Combine
import SwiftUI

final class DessertDetailViewModel: ObservableObject {
    @Published var uiState: State = .loading
    let useCase: DessertsUseCaseProtocol

    var subscriptions: Set<AnyCancellable> = []

    init(useCase: DessertsUseCaseProtocol) {
        self.useCase = useCase
    }

    func refresh(with id: String) {
        if uiState != .loading {
            uiState = .loading
        }

        useCase.retrieveDessertDetail(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { model in
                self.uiState = .idle(model)
            })
            .store(in: &subscriptions)
    }
}

extension DessertDetailViewModel {
    enum State: Equatable {
        case loading
        case idle(_ model: DessertDetailUIModel)
        case error
    }
}

struct DessertDetailUIModel: Equatable {
    let name: String
    let instructions: String
    let imageURL: String
    let ingredients: [String: String]
}

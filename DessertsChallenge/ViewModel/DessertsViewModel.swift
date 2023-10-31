//
//  DessertsViewModel.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import Combine
import SwiftUI

final class DessertsViewModel: ObservableObject {
    @Published var uiState: State = .loading
    let useCase: DessertsUseCaseProtocol

    var subscriptions: Set<AnyCancellable> = []

    init(useCase: DessertsUseCaseProtocol) {
        self.useCase = useCase
    }

    func refresh() {
        if uiState != .loading {
            uiState = .loading
        }

        useCase.retrieveDesserts()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { model in
                self.uiState = .idle(model)
            })
            .store(in: &subscriptions)
    }
}

extension DessertsViewModel {
    enum State: Equatable {
        case loading
        case idle(_ model: [DessertItem])
        case error
    }
}

struct DessertItem: Equatable, Identifiable, Comparable {
    let id: String
    let name: String
    let thumbnailURL: String

    static func < (lhs: DessertItem, rhs: DessertItem) -> Bool {
        lhs.name < rhs.name
    }
}


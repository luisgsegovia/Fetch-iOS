//
//  DessertDetail.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct DessertDetail: View {
    let dessert: DessertItem
    @StateObject var viewModel: DessertDetailViewModel

    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .loading:
               LoadingState()
            case .idle(let model):
                DessertDetailInnerView(model: model)
            case .error:
                ErrorState(action: { viewModel.refresh(with: dessert.id) })
            }
        }
        .onAppear { viewModel.refresh(with: dessert.id) }
    }
}

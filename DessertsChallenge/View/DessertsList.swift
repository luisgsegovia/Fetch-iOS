//
//  DessertsList.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct DessertsList: View {
    @StateObject var viewModel: DessertsViewModel

    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .loading:
                LoadingState()
            case .idle(let model):
                NavigationSplitView {
                    List(model) { item in
                        NavigationLink {
                            DessertDetail(dessert: item, viewModel: .init(useCase: DessertsUseCase(apiClient: APIService())))
                        } label: {
                            DessertsListItem(title: item.name, url: item.thumbnailURL)
                        }
                    }
                    .navigationTitle("Desserts")
                } detail: {
                    Text("Select a dessert")
                }
            case .error:
                ErrorState(action: viewModel.refresh)
            }
        }
        .onAppear(perform: viewModel.refresh)
    }
}

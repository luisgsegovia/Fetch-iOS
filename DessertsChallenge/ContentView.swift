//
//  ContentView.swift
//  DessertsChallenge
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DessertsList(viewModel: .init(useCase: DessertsUseCase(apiClient: APIService())))
    }
}

#Preview {
    ContentView()
}

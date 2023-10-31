//
//  ErrorState.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct ErrorState: View {
    let size: CGFloat = 144
    let action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 8) {
                Image("errorIcon")
                    .resizable()
                    .frame(width: size, height: size)
                Text("There was an error loading this information")
                    .bold()
                Button("Retry", action: action)
                    .buttonStyle(.bordered)
            }
            Spacer()
        }
    }
}

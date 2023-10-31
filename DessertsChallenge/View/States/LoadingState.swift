//
//  LoadingState.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct LoadingState: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(2.0, anchor: .center)
                .progressViewStyle(.circular)
            Spacer()
        }
    }
}

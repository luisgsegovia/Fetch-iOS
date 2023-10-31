//
//  DessertsListItem.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct DessertsListItem: View {
    let title: String
    let url: String

    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: url)!) { phase in
                if let image = phase.image {
                    image.resizable(capInsets: .init(), resizingMode: .stretch)
                }
            }
                .frame(width: 100, height: 100)
            Text(title)
        }
    }
}

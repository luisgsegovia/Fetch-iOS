//
//  DessertDetailInnerView.swift
//  DessertsTest
//
//  Created by Luis Segovia on 30/10/23.
//

import SwiftUI

struct DessertDetailInnerView: View {
    let model: DessertDetailUIModel

    var body: some View {
        List {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: model.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                    }
                }
                Text(model.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            Section("Ingredients") {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("Measure")
                        Text("Ingredients")
                    }
                    .bold()
                    Divider()
                    ForEach(model.ingredients.map { Ingredient(title: $0.key, measure: $0.value) }) { ingredient in
                        GridRow {
                            Text(ingredient.measure)
                            Text(ingredient.title)
                        }
                        Divider()
                    }
                }
            }

            Section("Instructions") {
                Text(model.instructions)
            }
        }
    }

    private struct Ingredient: Identifiable {
        let id: UUID
        let title: String
        let measure: String

        init(id: UUID = UUID(), title: String, measure: String) {
            self.id = id
            self.title = title
            self.measure = measure
        }
    }
}

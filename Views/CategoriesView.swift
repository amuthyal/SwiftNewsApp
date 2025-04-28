//
//  CategoriesView.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import SwiftUI

struct CategoriesView: View {
    var onCategorySelected: (NewsCategory) -> Void

    var body: some View {
        List {
            ForEach(NewsCategory.allCases, id: \.self) { category in
                Button(action: {
                    onCategorySelected(category)
                }) {
                    Text(category.rawValue.capitalized)
                        .padding()
                }
            }
        }
    }
}

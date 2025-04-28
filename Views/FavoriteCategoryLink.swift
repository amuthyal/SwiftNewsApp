//
//  FavoriteCategoryLink.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct FavoriteCategoryLink: View {
    var topic: String
    @Binding var savedArticles: [Article]
    @Binding var selectedArticle: IdentifiableURL?
    let onSave: () -> Void
    let showToastMessage: (String) -> Void

    var body: some View {
        NavigationLink(destination:
            FavoritesView(
                favoriteKeyword: topic,
                savedArticles: $savedArticles,
                onSave: onSave,
                showToastMessage: showToastMessage
            )
        ) {
            Label(topic.capitalized, systemImage: "star.fill")
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}

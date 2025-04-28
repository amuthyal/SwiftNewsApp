//
//  SavedArticlesLink.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct SavedArticlesLink: View {
    @Binding var savedArticles: [Article]
    let onSave: () -> Void
    let showToastMessage: (String) -> Void

    var body: some View {
        NavigationLink(destination:
            SavedArticlesView(
                savedArticles: $savedArticles,
                onSave: onSave,
                showToastMessage: showToastMessage
            )
        ) {
            Label("View Bookmarked Articles", systemImage: "bookmark.fill")
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}

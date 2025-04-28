//
//  SavedArticlesView.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct SavedArticlesView: View {
    @Binding var savedArticles: [Article]
    let onSave: () -> Void
    let showToastMessage: (String) -> Void

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            if savedArticles.isEmpty {
                VStack {
                    Image(systemName: "bookmark.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("No bookmarks yet")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(savedArticles, id: \.url) { article in
                            ArticleRow(
                                article: article,
                                isSaved: true,
                                onBookmarkTapped: {
                                    if let index = savedArticles.firstIndex(of: article) {
                                        savedArticles.remove(at: index)
                                        onSave()
                                        showToastMessage("Removed from Bookmarks")
                                    }
                                }
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .navigationTitle("Saved Articles")
    }
}


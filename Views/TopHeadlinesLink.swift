//
//  TopHeadlinesLink.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct TopHeadlinesLink: View {
    var viewModel: NewsViewModel
    @Binding var selectedArticle: IdentifiableURL?
    @Binding var searchText: String
    @Binding var savedArticles: [Article]
    let onSave: () -> Void
    let showToastMessage: (String) -> Void

    var body: some View {
        NavigationLink(destination:
            ContentView(
                viewModel: viewModel,
                selectedArticle: $selectedArticle,
                searchText: $searchText,
                savedArticles: $savedArticles,
                onSave: onSave,
                showToastMessage: showToastMessage,
                selectedCategory: "general"
            )
        ) {
            Label("Top Headlines", systemImage: "newspaper")
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}

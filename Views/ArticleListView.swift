import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @Binding var savedArticles: [Article]
    var onSave: () -> Void
    var showToastMessage: (String) -> Void

    @State private var searchText = ""

    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                ($0.description?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    var body: some View {
        NavigationStack {   // ✅ Add NavigationStack HERE
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredArticles, id: \.url) { article in
                        ArticleRow(
                            article: article,
                            isSaved: savedArticles.contains(article),
                            onBookmarkTapped: {
                                if let index = savedArticles.firstIndex(of: article) {
                                    savedArticles.remove(at: index)
                                    showToastMessage("Removed from Bookmarks")
                                } else {
                                    savedArticles.append(article)
                                    showToastMessage("Bookmarked!")
                                }
                                onSave()
                            }
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Top Headlines") // ✅ Now this will show!
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search articles...") // ✅ Now Search Bar will show!
        }
    }
}


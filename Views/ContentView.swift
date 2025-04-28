import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: NewsViewModel
    @Binding var selectedArticle: IdentifiableURL?
    @Binding var searchText: String
    @Binding var savedArticles: [Article]
    let onSave: () -> Void
    let showToastMessage: (String) -> Void
    let selectedCategory: String

    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return selectedArticles()
        } else {
            return selectedArticles().filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                ($0.description?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if viewModel.isLoading && filteredArticles.isEmpty {
                ProgressView("Loading...")
            } else if filteredArticles.isEmpty {
                VStack {
                    Spacer()
                    Text("No articles found.")
                        .foregroundColor(.gray)
                    Spacer()
                }
            } else {
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
                            .onTapGesture {
                                if let url = URL(string: article.url) {
                                    selectedArticle = IdentifiableURL(url: url)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
        .navigationTitle(titleForNavigation()) // ✅ Corrected here
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchArticles()
        }
    }

    // MARK: - Helper Functions

    private func fetchArticles() {
        if selectedCategory == "SavedArticles" {
            // Do not fetch when viewing saved articles
            return
        } else {
            viewModel.fetchTopHeadlines(category: selectedCategory == "general" ? "general" : selectedCategory.lowercased())
        }
    }

    private func selectedArticles() -> [Article] {
        if selectedCategory == "SavedArticles" {
            return savedArticles
        } else {
            return viewModel.articles
        }
    }

    private func titleForNavigation() -> String {
        if selectedCategory == "SavedArticles" {
            return "Saved Articles"
        } else if selectedCategory == "general" {
            return "Top Headlines"
        } else {
            return selectedCategory.capitalized
        }
    }
}


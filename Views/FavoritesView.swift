// FavoritesView.swift
import SwiftUI

struct FavoritesView: View {
    let favoriteKeyword: String
    @Binding var savedArticles: [Article]
    let onSave: () -> Void
    let showToastMessage: (String) -> Void

    @State private var articles: [Article] = []
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .padding(.top, 100)
            } else if articles.isEmpty {
                Text("No articles found.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top, 100)
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(articles, id: \.url) { article in
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
        }
        .navigationTitle(favoriteKeyword.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchFavoriteArticles()
        }
    }

    private func fetchFavoriteArticles() {
        isLoading = true
        
        // Fetch articles matching the favorite keyword
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("❌ Missing API Key")
            isLoading = false
            return
        }

        let query = favoriteKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? favoriteKeyword
        let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                print("❌ Error fetching favorites:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    articles = decoded.articles ?? []
                }
            } catch {
                print("❌ Error decoding favorites:", error.localizedDescription)
            }
        }.resume()
    }
}


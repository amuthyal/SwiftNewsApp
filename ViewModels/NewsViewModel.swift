import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    
    func fetchTopHeadlines() {
        isLoading = true
        NewsService.shared.fetchTopHeadlines { [weak self] articles in
            self?.articles = articles
            self?.isLoading = false
        }
    }
    
    func fetchTopHeadlines(category: String = "general") {
        isLoading = true
        NewsService.shared.fetchTopHeadlines(category: category) { articles in
            DispatchQueue.main.async {
                self.articles = articles
                self.isLoading = false
            }
        }
    }
    
}

import Foundation

class NewsService {
    static let shared = NewsService()

    private init() {}

    func fetchTopHeadlines(category: String = "general", completion: @escaping ([Article]) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("❌ Missing API Key")
            completion([])
            return
        }

        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching top headlines:", error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data else {
                print("❌ No data received for top headlines")
                completion([])
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.articles ?? [])
                }
            } catch {
                print("❌ Error decoding top headlines:", error.localizedDescription)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }

    func searchArticles(for query: String, completion: @escaping ([Article]) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("❌ Missing API Key")
            completion([])
            return
        }

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "https://newsapi.org/v2/everything?q=\(encodedQuery)&sortBy=publishedAt&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("❌ Invalid search URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching search results:", error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data else {
                print("❌ No data received for search")
                completion([])
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse.articles ?? [])
                }
            } catch {
                print("❌ Error decoding search results:", error.localizedDescription)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}


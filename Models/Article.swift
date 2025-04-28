import Foundation

struct Article: Codable, Identifiable, Equatable {
    var id: String { url } // ✅ use URL as unique ID
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
}



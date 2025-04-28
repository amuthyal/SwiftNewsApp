import SwiftUI

struct ArticleRow: View {
    let article: Article
    let isSaved: Bool
    let onBookmarkTapped: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.2)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Color.gray.opacity(0.3)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            }

            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)

            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack {
                Text(article.publishedAt)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: onBookmarkTapped) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}



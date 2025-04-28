import SwiftUI

struct ArticleRow: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlToImage = article.urlToImage,
               let url = URL(string: urlToImage) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(8)
                    } else if phase.error != nil {
                        Color.gray.frame(height: 200)
                    } else {
                        ProgressView().frame(height: 200)
                    }
                }
            }
            
            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

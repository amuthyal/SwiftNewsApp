//
//  BookmarkManager.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import Foundation

class BookmarkManager {
    static let shared = BookmarkManager() // ✅ Add this
    
    private var savedArticles: [Article] = []
    
    private init() {} // ✅ Private to ensure Singleton
    
    func addBookmark(_ article: Article) {
        savedArticles.append(article)
    }
    
    func removeBookmark(_ article: Article) {
        savedArticles.removeAll { $0.url == article.url }
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        savedArticles.contains { $0.url == article.url }
    }
    
    func getBookmarks() -> [Article] {
        return savedArticles
    }
}


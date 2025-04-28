//
//  Screen.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import Foundation

enum Screen: String, CaseIterable {
    case topHeadlines = "Top Headlines"
    case categories = "Categories"
    case favorites = "Favorites"

    var title: String {
        switch self {
        case .topHeadlines: return "Top Headlines"
        case .categories: return "Categories"
        case .favorites: return "Saved Articles"
        }
    }
}

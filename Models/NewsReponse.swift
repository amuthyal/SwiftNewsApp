//
//  NewsReponse.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

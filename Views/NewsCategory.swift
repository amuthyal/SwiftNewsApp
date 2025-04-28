//
//  NewsCategory.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology

    var id: String { self.rawValue }
}

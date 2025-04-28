//
//  Constants.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import Foundation

struct Constants {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
}

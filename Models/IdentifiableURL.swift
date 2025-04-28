//
//  IdentifiableURL.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//


import Foundation

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

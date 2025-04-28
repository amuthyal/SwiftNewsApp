//
//  Extensions.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import Foundation
import SwiftUI

// ✅ Make URL Identifiable (needed for .sheet(item:) to work properly)
extension URL: Identifiable {
    public var id: String { absoluteString }
}

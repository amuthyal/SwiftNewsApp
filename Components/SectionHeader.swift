//
//  SectionHeader.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

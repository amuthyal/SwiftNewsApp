//
//  AddCategoryButton.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/27/25.
//

import SwiftUI

struct AddCategoryButton: View {
    @Binding var showingAddAlert: Bool

    var body: some View {
        Button(action: {
            showingAddAlert = true
        }) {
            Label("Add Category", systemImage: "plus")
                .foregroundColor(.blue)
                .padding(.horizontal)
        }
    }
}

//
//  ArticleDetailView.swift
//  SwiftNews
//
//  Created by Akhila Muthyala on 4/26/25.
//

import SwiftUI
import SafariServices

struct ArticleDetailView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No update needed
    }
}

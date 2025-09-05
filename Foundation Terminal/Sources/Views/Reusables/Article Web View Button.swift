//
//  Article Web View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 06.09.2025.
//

import SwiftUI
import SafariServices

struct ArticleWebViewButton: View
{
    
    let article: Article
    
    var body: some View
    {
        Button
        {
            let safariViewController: SFSafariViewController = .init(url: article.articleType.fullArticleURL)
            
            UIApplication.shared.firstKeyWindow?.rootViewController?.present(safariViewController, animated: true)
        } label: {
            Label("action.open-article.\(article.friendlyName)", systemImage: "book")
        }

    }
}

private extension UIApplication
{
    var firstKeyWindow: UIWindow?
    {
        return UIApplication.shared.connectedScenes
            .compactMap{ $0 as? UIWindowScene }
            .filter{ $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}

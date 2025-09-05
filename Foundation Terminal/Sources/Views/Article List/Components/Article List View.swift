//
//  Article List View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftData
import SwiftUI

struct ArticleListView: View
{
    @Query var savedArticles: [Article]

    var body: some View
    {
        List(savedArticles)
        { savedArticle in
            NavigationLink(value: savedArticle)
            {
                Text(savedArticle.articleLink.absoluteString)
            }
        }
        .navigationTitle("article-list.title")
        .navigationDestination(for: Article.self)
        { article in
            Text(article.articleLink.absoluteString)
        }
        .toolbar
        {
            ToolbarItem(placement: .topBarTrailing)
            {
                OpenArticleSavingSheetButton()
            }
        }
    }
}

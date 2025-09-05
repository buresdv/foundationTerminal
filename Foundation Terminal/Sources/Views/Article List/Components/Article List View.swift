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
                articleListItem(article: savedArticle)
            }
        }
        .navigationTitle("article-list.title")
        .navigationDestination(for: Article.self)
        { article in
            ArticleDetailsView(article: article)
        }
        .toolbar
        {
            ToolbarItem(placement: .topBarTrailing)
            {
                OpenArticleSavingSheetButton()
            }
        }
    }
    
    @ViewBuilder
    func articleListItem(article: Article) -> some View
    {
        VStack(alignment: .leading)
        {
            Text(article.friendlyName)
                .font(.headline)
            
            if let notes = article.customDescription
            {
                Text(notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text(article.readingStatus.description)
                .font(.caption)
        }
    }
}

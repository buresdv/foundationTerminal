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
    @Query var savedCategories: [SavedArticleCategory]

    var body: some View
    {
        Group
        {
            if savedCategories.isEmpty
            {
                articleListWithoutCategories(articles: savedArticles)
            }
            else
            {
                articleListViewWithCategories(categories: savedCategories, articles: savedArticles)
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
        NavigationLink(value: article)
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

    @ViewBuilder
    func articleListWithoutCategories(articles: [Article]) -> some View
    {
        List(articles)
        { savedArticle in
            articleListItem(article: savedArticle)
        }
    }

    @ViewBuilder
    func articleListViewWithCategories(categories: [SavedArticleCategory], articles: [Article]) -> some View
    {
        List
        {
            ForEach(categories)
            { savedCategory in

                if savedCategory.articles != nil
                {
                    if !savedCategory.articles!.isEmpty
                    {
                        Section
                        {
                            ForEach(articles.filter { $0.category == savedCategory })
                            { filteredArticle in
                                articleListItem(article: filteredArticle)
                            }
                        } header: {
                            Text(savedCategory.name)
                                .headerProminence(.increased)
                        }
                    }
                }
            }

            Section("uncategorized.label")
            {
                ForEach(articles.filter { $0.category == nil })
                { uncategorizedArticle in
                    articleListItem(article: uncategorizedArticle)
                }
            }
        }
    }
}

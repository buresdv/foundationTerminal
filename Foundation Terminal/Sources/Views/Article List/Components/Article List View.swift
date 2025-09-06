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
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @Query var savedArticles: [Article]
    @Query var savedCategories: [SavedArticleCategory]
    
    // MARK: - Predicates
    private let bookmarkedArticlesFilterPredicate: Predicate<Article> = #Predicate {
        $0.isBookmarked == true
    }
    
    var bookmarkedSavedArticles: [Article]?
    {
        
        return try? savedArticles.filter(bookmarkedArticlesFilterPredicate)
    }

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
        .toolbar
        {
            EditButton()
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
        List
        {
            ForEach(articles)
            { savedArticle in
                articleListItem(article: savedArticle)
            }
            .onDelete(perform: deleteSavedArticle)
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
            .onDelete(perform: deleteSavedArticle)

            Section("uncategorized.label")
            {
                ForEach(articles.filter { $0.category == nil })
                { uncategorizedArticle in
                    articleListItem(article: uncategorizedArticle)
                }
                .onDelete(perform: deleteSavedArticle)
            }
        }
    }
    
    @ViewBuilder
    var bookmarkedArticles: some View
    {
        if let bookmarkedSavedArticles
        {
            ScrollView
            {
                ForEach(bookmarkedSavedArticles)
                { bookmarkedArticle in
                    articleListItem(article: bookmarkedArticle)
                }
            }
        }
    }
    
    func deleteSavedArticle(_ indexSet: IndexSet)
    {
        for index in indexSet
        {
            let articleToDelete = savedArticles[index]
            
            withAnimation
            {
                modelContext.delete(articleToDelete)
            }
        }
    }
}

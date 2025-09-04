//
//  Article List.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import SwiftData
import SwiftUI

struct ArticleListView: View
{
    @Environment(\.modelContext) var modelContext: ModelContext

    @Environment(AppState.self) var appState: AppState

    @Query var savedArticles: [Article]

    var body: some View
    {
        NavigationStack
        {
            if savedArticles.isEmpty
            {
                noArticlesSavedYetView
            }
            else
            {
                articleList
            }
        }
    }

    @ViewBuilder
    var noArticlesSavedYetView: some View
    {
        ContentUnavailableView
        {
            Label("status.no-articles-saved.title", systemImage: "bookmark")
        } description: {
            EmptyView()
        } actions: {
            Button
            {
                appState.sheetManager.showSheet(.addArticle)
            } label: {
                Label("action.add-article", systemImage: "plus")
            }
        }
    }

    @ViewBuilder
    var articleList: some View
    {
        List(savedArticles)
        { savedArticle in
            NavigationLink(value: savedArticle)
            {
                Text(savedArticle.articleLink.absoluteString)
            }
        }
    }
}

//
//  Add Article View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import ButtonKit
import FoundationTerminalHTMLLogic
import FoundationTerminalShared
import SwiftUI

struct AddArticleView: View
{
    @Environment(\.articleManager) var articleManager: ArticleManager
    @Environment(\.terminalHTMLParser) var terminalHTMLParser: TerminalHTMLParser
    @Environment(AppState.self) var appState: AppState

    enum FocusableField
    {
        case articleNumber
    }

    /// A way to identify the article in the first phase of putting it in. Can be either:
    /// - direct URL to the article
    /// - article number
    @State private var articleNumber: Int = .zero

    @FocusState var focusableField: FocusableField?

    @State private var isLoadingArticleData: Bool = false

    enum AddArticleState
    {
        case initial
        case loaded(_ loadedData: Data)
    }

    @State private var addArticleState: AddArticleState = .initial

    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section
                {
                    TextField(
                        value: $articleNumber,
                        format: .number,
                        prompt: Text("add-article.article-identifier.prompt")
                    )
                    {
                        Text("add-article.article-identifier.placeholder")
                    }
                    .focused($focusableField, equals: .articleNumber)
                    .keyboardType(.numberPad)
                    .submitLabel(.search)

                    AsyncButton
                    {
                        do throws(ArticleManager.DataLoadingError)
                        {
                            let loadedData = try await articleManager.loadDataFromWiki(.scp(.init(integerLiteral: articleNumber)))

                            addArticleState = .loaded(loadedData)
                        }
                        catch let articleLoadingError
                        {
                            AppConstants.shared.logger.error("Failed while trying to load article data: \(articleLoadingError.localizedDescription)")

                            appState.alertManager.showAlert(.failedToLoadArticleDetails(error: articleLoadingError))
                        }
                    } label: {
                        Label("action.search", systemImage: "magnifyingglass")
                    }
                    .asyncButtonStyle(.overlay(style: .percent))
                }

                switch addArticleState
                {
                case .initial:
                    initialArticleView
                case .loaded(let loadedData):
                    LoadedDetailsView(articleData: loadedData)
                }
            }
            .navigationTitle("add-article.title")
        }
        .onAppear
        {
            focusableField = .articleNumber
        }
    }

    @ViewBuilder
    var initialArticleView: some View
    {
        EmptyView()
    }
}

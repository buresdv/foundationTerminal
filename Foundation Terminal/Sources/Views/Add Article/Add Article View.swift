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
        case loading
        case loaded(_ loadedData: Data)
    }

    @State private var addArticleState: AddArticleState = .initial
    
    @State private var articleNotes: String = .init()
    @State private var seletedCategory: SavedArticleCategory?
    
    @Observable
    final class InternalNavigationManager
    {
        enum NavigationDestination: Hashable
        {
            case createCategory
        }
        
        var path: NavigationPath = .init()
        
        func navigate(to navigationDestination: InternalNavigationManager.NavigationDestination)
        {
            self.path.append(navigationDestination)
        }
        
        func goBack()
        {
            self.path.removeLast()
        }
    }
    
    @State private var internalNavigationManager: InternalNavigationManager = .init()

    var body: some View
    {
        NavigationStack(path: Bindable(internalNavigationManager).path)
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
                            AppConstants.shared.logger.debug("Will initialize article loading")
                            
                            addArticleState = .loading
                            
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
                        .onAppear
                        {
                            AppConstants.shared.logger.debug("[NEW ADD ARTICLE VIEW]: Initial")
                        }
                case .loading:
                    ProgressView()
                        .onAppear
                        {
                            AppConstants.shared.logger.debug("[NEW ADD ARTICLE VIEW]: Loading")
                        }
                case .loaded(let loadedData):
                    LoadedDetailsView(articleData: loadedData, articleType: .scp(.init(integerLiteral: articleNumber)))
                        .onAppear
                        {
                            AppConstants.shared.logger.debug("[NEW ADD ARTICLE VIEW]: Loaded")
                        }
                    
                    ArticleCategoriesView(selectedCategory: $seletedCategory)
                    
                    ArticleNotesView(notes: $articleNotes)
                }
            }
            .navigationTitle("add-article.title")
            .environment(internalNavigationManager)
            .navigationDestination(for: AddArticleView.InternalNavigationManager.NavigationDestination.self) { internalNavigationDestination in
                switch internalNavigationDestination
                {
                case .createCategory:
                    AddCategoryView()
                }
            }
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

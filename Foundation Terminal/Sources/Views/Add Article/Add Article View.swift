//
//  Add Article View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import FoundationTerminalShared
import SwiftUI
import ButtonKit

struct AddArticleView: View
{
    @Environment(\.articleManager) var articleManager: ArticleManager
    
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
                    .submitLabel(.search)
                    .onSubmit(of: .search)
                    {
                        Task
                        {
                            do
                            {
                                let loadedData = try await articleManager.loadDataFromWiki(.scp(articleNumber))
                            }
                            catch let articleLoadingError
                            {
                                AppConstants.shared.logger.error("Failed while trying to load article data: \(articleLoadingError.localizedDescription)")
                            }
                        }
                    }
                    
                    Button
                    {
                        AppConstants.shared.logger.info("Clicked")
                    } label: {
                        Label("action.check-article-validity", systemImage: "magnifyingglass")
                    }
                }
            }
            .navigationTitle("add-article.title")
        }
        .onAppear
        {
            focusableField = .articleNumber
        }
    }
}

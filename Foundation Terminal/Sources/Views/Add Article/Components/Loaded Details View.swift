//
//  Loaded Details View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import SwiftUI
import FoundationTerminalShared

struct LoadedDetailsView: View
{
    @Environment(\.terminalHTMLParser) var terminalHTMLParser: TerminalHTMLParser

    let articleData: Data
    let articleType: ArticleType

    enum DetailsLoadingState
    {
        case loading
        case loaded(loadedArticleDetails: ArticleDetails)
        case failed(_ error: String)
    }

    @State private var detailsLoadingState: DetailsLoadingState = .loading

    var body: some View
    {
        
        switch detailsLoadingState
        {
        case .loading:
            ProgressView()
                .task
                {
                    await self.parseArticleDetails()
                }
            
        case .loaded(let loadedArticleDetails):
            Section("add-article.article-details.header")
            {
                LabeledContent {
                    if let articleTitle = loadedArticleDetails.title
                    {
                        Text(articleTitle)
                    }
                    else
                    {
                        Text("data.missing")
                            .disabled(true)
                    }
                } label: {
                    Text("article.title")
                }
                
                LabeledContent {
                    if let articleRating = loadedArticleDetails.rating
                    {
                        Text(articleRating.formatted(.number))
                    }
                    else
                    {
                        Text("data.missing")
                            .disabled(true)
                    }
                } label: {
                    Text("article.rating")
                }

            }
            .onChange(of: articleData)
            { _, _ in
                self.detailsLoadingState = .loading
            }
            
        case .failed(let loadingError):
            Text(loadingError)
        }
    }
    
    func parseArticleDetails() async
    {
        AppConstants.shared.logger.debug("Will try to parse article data")
        
        do
        {
            
            let parsedArticle: ArticleDetails = try await terminalHTMLParser.getDetailsFromRawArticle(
                articleData, articleType: articleType
            )
            
            self.detailsLoadingState = .loaded(loadedArticleDetails: parsedArticle)
        }
        catch let articleParsingError
        {
            AppConstants.shared.logger.error("Failed while parsing article data: \(articleParsingError.localizedDescription)")
            
            self.detailsLoadingState = .failed(articleParsingError.localizedDescription)
        }
    }
}

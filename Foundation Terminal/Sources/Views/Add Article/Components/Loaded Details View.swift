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

    enum DetailsLoadingState
    {
        case loading
        case loaded(loadedArticleDetails: ParsedDetails)
        case failed(_ error: String)
    }

    struct ParsedDetails
    {
        let articleTitle: String?
    }

    @State private var detailsLoadingState: DetailsLoadingState = .loading

    var body: some View
    {
        Section("add-article.article-details.header")
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
                LabeledContent {
                    if let articleTitle = loadedArticleDetails.articleTitle
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

            case .failed(let loadingError):
                Text(loadingError)
            }
        }
    }

    func parseArticleDetails() async
    {
        AppConstants.shared.logger.debug("Will try to parse article data")
        
        do
        {
            let articleTitle: String? = try await terminalHTMLParser.getElementFromRawArticle(articleData, whatToGet: .title)
            
            let constructedArticleData: ParsedDetails = .init(
                articleTitle: articleTitle
            )
            
            self.detailsLoadingState = .loaded(loadedArticleDetails: constructedArticleData)
        }
        catch let articleParsingError
        {
            AppConstants.shared.logger.error("Failed while parsing article data: \(articleParsingError.localizedDescription)")
            
            self.detailsLoadingState = .failed(articleParsingError.localizedDescription)
        }
    }
}

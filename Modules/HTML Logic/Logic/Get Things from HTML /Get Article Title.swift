//
//  Get Article Title.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
@preconcurrency import SwiftHTMLParser
import FoundationTerminalShared

extension TerminalHTMLParser
{
    public enum ArticleElements
    {
        /// Title of the article
        case title
        
        /// Rating of the article
        case rating
    }
    
    /// Get the specified element from the raw article data
    public func getElementFromRawArticle(
        _ rawData: Data,
        whatToGet: ArticleElements
    ) async throws(HTMLParsingError) -> String? {
        do
        {
            let parsedArticleData: [Node] = try self.parse(rawData)
            
            return getElementFromParsedArticle(whatToGet, from: parsedArticleData)
        }
        catch let parsingError
        {
            throw parsingError
        }
    }
    
    /// Get all relevant details from the raw article data
    public func getDetailsFromRawArticle(
        _ rawData: Data,
        articleType: ArticleType
    ) async throws(HTMLParsingError) -> ArticleDetails {
        do
        {
            let parsedArticleData: [Node] = try self.parse(rawData)
            
            let articleTitle: String? = self.getElementFromParsedArticle(.title, from: parsedArticleData)
            
            let articleRating: Int? = {
                let ratingAsString: String? = self.getElementFromParsedArticle(.rating, from: parsedArticleData)
                
                guard let unwrappedRatingAsString: String = ratingAsString else
                {
                    return nil
                }
                
                return Int(unwrappedRatingAsString)
            }()
            
            return .init(title: articleTitle, type: articleType, rating: articleRating)
            
        } // Parsing the raw data
        catch let parsingError
        {
            throw parsingError
        }
    }
    
    private func getElementFromParsedArticle(
        _ elementToGet: ArticleElements,
        from parsedNodes: [Node]
    ) -> String?
    {
        switch elementToGet
        {
        case .title:
            return self.getTitle(from: parsedNodes)
        case .rating:
            return self.getRating(from: parsedNodes)
        }
    }
    
    private func getTitle(
        from parsedNodes: [Node]
    ) -> String?
    {
        let foundElements: [Element] = HTMLTraverser.findElements(in: parsedNodes, matching: TerminalHTMLParser.articleTitleSelector)
        
        LibraryConstants.shared.logger.debug("Found these elements while traversing for [ARTICLE TITLE]: \(foundElements)")
        
        guard let rawTitle: String? = foundElements.first?.textNodes.first?.text else
        {
            return nil
        }
        
        return rawTitle?.replacingOccurrences(of: " - SCP Foundation", with: "")
    }
    
    private func getRating(
        from parsedNodes: [Node]
    ) -> String?
    {
        let foundElements: [Element] = HTMLTraverser.findElements(in: parsedNodes, matching: TerminalHTMLParser.ratingSelector)
        
        LibraryConstants.shared.logger.debug("Found these elements while traversing for [ARTICLE RATING]: \(foundElements)")
        
        return foundElements.first?.textNodes.first?.text
    }
}

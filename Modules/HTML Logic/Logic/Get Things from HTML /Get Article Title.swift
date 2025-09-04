//
//  Get Article Title.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
@preconcurrency import SwiftHTMLParser

extension TerminalHTMLParser
{
    public enum ArticleElements
    {
        /// Title of the article
        case title
    }
    
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
    
    private func getElementFromParsedArticle(
        _ elementToGet: ArticleElements,
        from parsedNodes: [Node]
    ) -> String?
    {
        switch elementToGet
        {
        case .title:
            return self.getTitle(from: parsedNodes)
        }
    }
    
    private func getTitle(
        from parsedNodes: [Node]
    ) -> String?
    {
        let foundElements: [Element] = HTMLTraverser.findElements(in: parsedNodes, matching: TerminalHTMLParser.articleTitleSelector)
        
        LibraryConstants.shared.logger.debug("Found these elements while traversing: \(foundElements)")
        
        return foundElements.first?.textNodes.first?.text
    }
}

//
//  HTMLParser.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
import SwiftHTMLParser

public actor TerminalHTMLParser
{
    public init() {}
    
    public enum HTMLParsingError: LocalizedError
    {
        case couldNotConvertDataToString
        case couldNotParseHTML(error: String)
        
        public var errorDescription: String?
        {
            switch self {
            case .couldNotConvertDataToString:
                return String(localized: "html-parsing.error.coult-not-convert-data-to-string")
            case .couldNotParseHTML(let error):
                return String(localized: "html-parsing.error.could-not-parse-html.\(error)")
            }
        }
    }
    
    /// Process the raw HTML into nodes for further use
    public func parse(
        _ data: Data
    ) throws(HTMLParsingError) -> [Node]
    {
        guard let dataAsString: String = String(data: data, encoding: .utf8) else
        {
            throw .couldNotConvertDataToString
        }
        
        do
        {
            let nodeTree: [Node] = try HTMLParser.parse(dataAsString)
            
            return nodeTree
        }
        catch let parsingError
        {
            LibraryConstants.shared.logger.error("Failed while parsing HTML: \(parsingError.localizedDescription)")
            
            throw .couldNotParseHTML(error: parsingError.localizedDescription)
        }
    }
    
    public func findNodesInParsedHTML(
        _ nodes: [Node],
        using nodeSelectors: [NodeSelector]
    ) throws -> [Node]
    {
        return HTMLTraverser.findNodes(in: nodes, matching: nodeSelectors)
    }
}

//
//  Predefined Node Selectors.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
@preconcurrency import SwiftHTMLParser

extension TerminalHTMLParser
{
    static let headSelector: [NodeSelector] = [
        ElementSelector().withTagName("html"),
        ElementSelector().withTagName("head")
    ]
    
    static let articleTitleSelector: [NodeSelector] = [
        headSelector,
        [
            ElementSelector().withTagName("title")
        ]
    ].flatMap{$0}
}

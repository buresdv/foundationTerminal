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
    
    static let bodySelector: [NodeSelector] = [
        ElementSelector().withTagName("html"),
        ElementSelector().withTagName("body")
    ]
    
    // MARK: - Specific element selectors
    
    static let articleTitleSelector: [NodeSelector] = [
        headSelector,
        [
            ElementSelector().withTagName("title")
        ]
    ].flatMap{$0}
    
    static let ratingSelector: [NodeSelector] = [
        bodySelector,
        [
            ElementSelector().withId("skrollr-body"),
            ElementSelector().withId("container-wrap-wrap"),
            ElementSelector().withId("container-wrap"),
            ElementSelector().withId("container"),
            ElementSelector().withId("content-wrap"),
            ElementSelector().withId("main-content"),
            ElementSelector().withId("page-content"),
            ElementSelector().withClassName("creditRate"),
            ElementSelector().withClassName("rateBox"),
            ElementSelector().withClassName("rate-box-with-credit-button"),
            ElementSelector().withClassName("page-rate-widget-box"),
            ElementSelector().withTagName("span").withClassName("rate-points")
        ]
    ].flatMap{$0}
}

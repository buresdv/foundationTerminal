//
//  Article Details.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import Foundation

/// Struct for storing parsed details about an article
public struct ArticleDetails: Codable, Sendable
{
    /// The title of the article - usually the SCP number
    let title: String?
    
    /// The type of the article
    let type: ArticleType?
    
    /// The rating of the article
    let rating: Int?
}

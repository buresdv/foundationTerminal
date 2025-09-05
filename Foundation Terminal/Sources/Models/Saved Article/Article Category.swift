//
//  Article Category.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import Foundation
import SwiftData

@Model
final class SavedArticleCategory
{
    /// Name of the category
    @Attribute(.unique)
    var name: String
    
    /// When this category was created
    var createdAt: Date
    
    /// Articles included in the category
    @Relationship(deleteRule: .cascade, inverse: \Article.category)
    var articles: [Article]?
    
    init(name: String)
    {
        self.name = name
        self.createdAt = .now
    }
}

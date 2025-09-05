//
//  Saved Article.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Article
{
    var articleType: ArticleType
    
    var articleLink: URL

    var customDescription: String?
    
    var category: SavedArticleCategory?
    
    @Transient
    var modelDesctiption: LocalizedStringKey = "model.article.description"
    
    init(articleType: ArticleType, articleLink: URL, customDescription: String? = nil)
    {
        self.articleType = articleType
        self.articleLink = articleLink
        self.customDescription = customDescription
    }
}

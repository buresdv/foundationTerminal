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
    enum ReadingStatus: Identifiable, Codable, Hashable, CustomStringConvertible, CaseIterable
    {
        static var allCases: [Article.ReadingStatus]
        {
            return [
                .planning,
                .reading(progress: nil),
                .finished(rating: nil)
            ]
        }
        
        case planning
        case reading(progress: Double?)
        case finished(rating: Rating?)

        var description: String
        {
            switch self
            {
            case .planning:
                return String(localized: "model.article.reading-status.planning")
            case .reading:
                return String(localized: "model.article.reading-status.reading")
            case .finished:
                return String(localized: "model.article.reading-status.finished")
            }
        }
        
        var id: Self
        {
            self
        }
    }

    enum Rating: Codable, CustomStringConvertible
    {
        case exceptional
        case good
        case average
        case poor
        case horrible

        var description: String
        {
            switch self
            {
            case .exceptional:
                return String(localized: "model.article.rating.exceptional")
            case .good:
                return String(localized: "model.article.rating.good")
            case .average:
                return String(localized: "model.article.rating.average")
            case .poor:
                return String(localized: "model.article.rating.poor")
            case .horrible:
                return String(localized: "model.article.rating.horrible")
            }
        }
    }

    var articleType: ArticleType

    var customDescription: String?

    var category: SavedArticleCategory?

    var readingStatus: ReadingStatus

    var createdAt: Date

    @Transient
    var articleLink: URL
    {
        return self.articleType.fullArticleURL
    }

    @Transient
    var modelDesctiption: LocalizedStringKey = "model.article.description"

    init(
        articleType: ArticleType,
        customDescription: String? = nil,
        category: SavedArticleCategory? = nil,
        readingStatus: ReadingStatus
    )
    {
        self.articleType = articleType
        self.customDescription = customDescription
        self.category = category
        self.readingStatus = readingStatus
        self.createdAt = .now
    }
}

//
//  Displayable Alert Descriptions.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

extension DisplayableAlert
{
    /// The bold text on top of the alert
    var errorDescription: String?
    {
        switch self
        {
        case .failedToInitializePersistenceContainer:
            return String(localized: "alert.failed-container-initialization.title")
        case .failedToLoadArticleDetails:
            return String(localized: "alert.could-not-load-article-details.title")
        }
    }
}

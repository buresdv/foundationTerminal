//
//  Displayable Alert Recovery Suggestions.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

extension DisplayableAlert
{
    var recoverySuggestion: String?
    {
        switch self
        {
        case .failedToInitializePersistenceContainer(let modelDescription, let error):
            return String(localized: "alert.failed-container-initialization.model-description-\(modelDescription).error-\(error.localizedDescription)")
        case .failedToLoadArticleDetails(let error):
            return error.localizedDescription
        }
    }
}

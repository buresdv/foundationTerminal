//
//  Displayable Alert.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

enum DisplayableAlert: LocalizedError
{
    case failedToInitializePersistenceContainer(modelDescription: LocalizedStringResource, error: Error)
    
    case failedToLoadArticleDetails(error: ArticleManager.DataLoadingError)
}

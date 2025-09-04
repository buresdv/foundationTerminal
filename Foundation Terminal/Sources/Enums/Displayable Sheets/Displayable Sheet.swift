//
//  Displayable Sheet.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

enum DisplayableSheet: Identifiable
{
    var id: UUID
    {
        return .init()
    }
    
    case addArticle
    case editArticle(Article)
}

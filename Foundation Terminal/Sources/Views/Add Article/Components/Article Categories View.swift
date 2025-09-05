//
//  Custom Article Details.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import Foundation
import SwiftData
import SwiftUI

struct ArticleCategoriesView: View
{
    @Environment(AddArticleView.InternalNavigationManager.self) var internalNavigationManager: AddArticleView.InternalNavigationManager

    @Binding var selectedCategory: SavedArticleCategory?

    @Query var availableCategories: [SavedArticleCategory]

    var body: some View
    {
        Section("add-article.article-category.header")
        {
            if !availableCategories.isEmpty
            {
                Picker(selection: $selectedCategory)
                {
                    Text("add-article.article-notes.category.no-category")
                        .tag(nil as SavedArticleCategory?)
                    
                    ForEach(availableCategories)
                    { availableCategory in
                        Text(availableCategory.name)
                            .tag(availableCategory)
                    }
                } label: {
                    Text("add-article.article-notes.category.label")
                }
            }
            
            Button
            {
                internalNavigationManager.navigate(to: .createCategory)
            } label: {
                Label("action.add-category", systemImage: "folder.badge.plus")
            }
        }
    }
}

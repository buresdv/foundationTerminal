//
//  Custom Article Details.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import Foundation
import SwiftData
import SwiftUI

struct ArticleNotesView: View
{
    @Environment(AddArticleView.InternalNavigationManager.self) var internalNavigationManager: AddArticleView.InternalNavigationManager

    @Binding var notes: String
    @Binding var selectedCategory: SavedArticleCategory?

    @Query var availableCategories: [SavedArticleCategory]

    @State private var isShowingNotesField: Bool = false

    @FocusState var isNotesFieldFocused: Bool

    var body: some View
    {
        Section("add-article.article-notes.header")
        {
            if !availableCategories.isEmpty
            {
                Picker(selection: $selectedCategory)
                {
                    ForEach(availableCategories)
                    { availableCategory in
                        Text(availableCategory.name)
                    }
                } label: {
                    Text("add-article.article-notes.category.label")
                }
            }
            else
            {
                Button
                {
                    internalNavigationManager.navigate(to: .createCategory)
                } label: {
                    Label("action.add-category", systemImage: "folder.badge.plus")
                }
            }

            if !isShowingNotesField
            {
                Button
                {
                    withAnimation
                    {
                        isShowingNotesField = true
                    }
                } label: {
                    Label("action.add-notes", systemImage: "book.pages")
                }
            }
            else
            {
                TextEditor(text: $notes)
                    .focused($isNotesFieldFocused)
                    .onAppear
                    {
                        isNotesFieldFocused = true
                    }
            }
        }
    }
}

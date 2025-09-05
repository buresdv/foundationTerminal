//
//  Add Category View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftData
import SwiftUI

struct AddCategoryView: View
{
    @Environment(\.modelContext) var modelContext: ModelContext
    //@Environment(AddArticleView.InternalNavigationManager.self) var internalNavigationManager: AddArticleView.InternalNavigationManager

    @Environment(\.dismiss) var dismiss: DismissAction
    
    @Bindable var newCategory: SavedArticleCategory = .init(
        name: .init()
    )

    @State private var notes: String = .init()
    
    @FocusState var isCategoryNameFieldFocused: Bool
    
    var body: some View
    {
        Form
        {
            TextField(text: $newCategory.name, prompt: Text("add-category.name.prompt"))
            {
                Text("add-category.name.label")
            }
            .onAppear
            {
                isCategoryNameFieldFocused = true
            }
            .focused($isCategoryNameFieldFocused)
            
            Section
            {
                ArticleNotesView(notes: $notes)
            }
        }
        .navigationTitle("add-category.title")
        .toolbar
        {
            ToolbarItem(placement: .topBarTrailing)
            {
                Button
                {
                    saveNewCategory()
                } label: {
                    Label("action.add-category", systemImage: "folder.badge.plus")
                }
            }
        }
    }
    
    func saveNewCategory()
    {
        
        if !notes.isEmpty
        {
            newCategory.notes = notes
        }
        
        modelContext.insert(newCategory)
        
        dismiss()
    }
}

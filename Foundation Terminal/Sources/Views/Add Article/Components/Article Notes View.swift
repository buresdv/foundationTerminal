//
//  Article Notes View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftUI

struct ArticleNotesView: View
{
    @Binding var notes: String

    @State private var isShowingNotesField: Bool = false

    @FocusState var isNotesFieldFocused: Bool

    var body: some View
    {
        Section
        {
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

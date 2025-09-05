//
//  Open Article Saving Sheet Button.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftUI

struct OpenArticleSavingSheetButton: View
{
    @Environment(AppState.self) var appState: AppState
    
    var body: some View
    {
        Button
        {
            appState.sheetManager.showSheet(.addArticle)
        } label: {
            Label("action.add-article", image: "custom.text.document.badge.plus")
        }
    }
}

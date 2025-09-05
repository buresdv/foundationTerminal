//
//  Start Page.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import SwiftUI

struct StartPage: View
{
    @Environment(AppState.self) var appState: AppState
    
    var body: some View
    {
        switch appState.startpageState
        {
        case .setUp:
            ArticleOverviewView()
        case .fatalError:
            fatalError
        }
    }

    @ViewBuilder
    var fatalError: some View
    {
        ContentUnavailableView("error.fatal", image: "custom.apple.terminal.2.trianglebadge.exclamationmark")
    }
}

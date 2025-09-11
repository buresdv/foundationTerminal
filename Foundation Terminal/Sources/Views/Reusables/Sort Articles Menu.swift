//
//  Sort Articles Menu.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 07.09.2025.
//

import SwiftUI

struct SortArticlesMenu: View
{
    @Binding var sortOrder: Article.SortBy

    var body: some View
    {
        Menu
        {
            Picker("action.sort", selection: $sortOrder)
            {
                ForEach(Article.SortBy.allCases)
                { sortCase in
                    Text(sortCase.description)
                }
            }
        } label: {
            Label("action.sort", systemImage: "line.3.horizontal.decrease")
        }
    }
}

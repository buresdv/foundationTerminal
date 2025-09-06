//
//  Bookmark Button.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 07.09.2025.
//

import SwiftUI

struct BookmarkButton: View
{
    @Bindable var article: Article
    
    var body: some View
    {
        Button
        {
            article.isBookmarked.toggle()
        } label: {
            Label("action.bookmark", systemImage: article.isBookmarked ? "bookmark.slash" : "bookmark")
        }
        .foregroundStyle(.yellow)
    }
}


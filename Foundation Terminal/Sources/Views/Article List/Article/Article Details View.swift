//
//  Article Details View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftUI

struct ArticleDetailsView: View
{
    
    @Bindable var article: Article
    
    var body: some View
    {
        Form
        {
            Section
            {
                ArticleWebViewButton(article: article)
            }
            
            if let notes = article.customDescription
            {
                TextEditor(text: .constant(notes))
            }
            
            ArticleReadingStatusView(readingStatus: $article.readingStatus)
        }
        .navigationTitle(article.friendlyName)
    }
}

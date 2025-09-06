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
                Section
                {
                    TextEditor(text: .constant(notes))
                }
            }

            Section
            {
                ArticleReadingStatusView(readingStatus: $article.readingStatus)

                switch article.readingStatus
                {
                case .planning:
                    EmptyView()
                case .reading:
                    LabeledContent
                    {
                        Spacer()
                        TextField(value: $article.readingProgress, format: .percent) {
                            Text("article-details.reading.label")
                        }
                        .keyboardType(.numberPad)
                    } label: {
                        Text("article-details.reading.label")
                    }

                case .finished:
                    Picker(selection: $article.rating)
                    {
                        Text("model.article.rating.none")
                            .tag(nil as Article.Rating?)
                        
                        Divider()

                        ForEach(Article.Rating.allCases)
                        { rating in
                            Label(rating.description, systemImage: rating.icon)
                                .tag(rating)
                        }
                    } label: {
                        Text("article-details.finished.label")
                    }
                }
            }
        }
        .navigationTitle(article.friendlyName)
    }
}

//
//  Article Reading Status View.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import SwiftUI

struct ArticleReadingStatusView: View
{
    @Binding var readingStatus: Article.ReadingStatus

    var body: some View
    {
        Picker(selection: $readingStatus)
        {
            ForEach(Article.ReadingStatus.allCases)
            { readingStatus in
                Text(readingStatus.description)
            }
        } label: {
            Text("add-article.reading-status.label")
        }
        .pickerStyle(.navigationLink)
    }
}

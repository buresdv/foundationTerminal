//
//  Article Type.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

enum ArticleType: Codable
{
    case scp(_ number: Int)
    case tale(_ address: String)

    var baseURLForLoading: URL
    {
        switch self
        {
        case .scp:
            return try! .init("https://scp-wiki.wikidot.com", strategy: .url)
        case .tale:
            return try! .init("https://scp-wiki.wikidot.com", strategy: .url)
        }
    }

    var fullArticleURL: URL
    {
        switch self
        {
        case .scp(let number):
            return baseURLForLoading.appendingPathComponent("scp-\(number)", conformingTo: .url)
        case .tale(let address):
            return baseURLForLoading.appendingPathComponent(address, conformingTo: .url)
        }
    }
}

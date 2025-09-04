//
//  Article Type.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation

enum ArticleType: Codable
{
    case scp(_ number: SCPNumber)
    case tale(_ address: String)

    struct SCPNumber: RawRepresentable, Codable, ExpressibleByIntegerLiteral, LosslessStringConvertible
    {
        let rawValue: Int

        init?(rawValue: Int)
        {
            guard rawValue >= 0 else { return nil }
            self.rawValue = rawValue
        }

        init?(_ description: String)
        {
            guard let convertedString = Int(description)
            else
            {
                return nil
            }

            self.rawValue = convertedString
        }

        init(integerLiteral value: Int)
        {
            self.rawValue = value
        }

        init(_ value: Int)
        {
            self.rawValue = .init(integerLiteral: value)
        }

        var description: String
        {
            let numberFormatter: NumberFormatter = {
                let numberFormatter: NumberFormatter = .init()
                numberFormatter.minimumIntegerDigits = 3

                return numberFormatter
            }()

            return numberFormatter.string(from: self.rawValue as NSNumber)!
        }
    }

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

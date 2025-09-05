//
//  Article Type.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 05.09.2025.
//

import Foundation

public enum ArticleType: Codable, Sendable, CustomStringConvertible
{
    case scp(_ number: SCPNumber)
    case tale(_ address: String)

    /*
     /// Initialize the enum based on the article URL
     init?(fromURL articleURL: URL)
     {
         /// For SCPs, the first path component is always "scp-[number]"; for tales, it is the tale URL
         guard let articleTypeDeterminingPathComponent = articleURL.pathComponents.first else
         {
             AppConstants.shared.logger.error("Couldn't extract determining path component from article URL")
             return nil
         }

         if articleTypeDeterminingPathComponent.contains("scp-\\d{3,}")
         {
             guard let scpNumberExtractionRegex: Regex = try? .init("\\d{3,}") else
             {
                 AppConstants.shared.logger.error("Couldn't construct REGEX for extracting SCP number")

                 return nil
             }

             let extractedSCPNumber = articleTypeDeterminingPathComponent.ranges(of: scpNumberExtractionRegex)

             self = .scp(.init(integerLiteral: Int(extractedSCPNumber)))
         }
         else
         {
             self = .tale(articleTypeDeterminingPathComponent)
         }
     }
      */

    public struct SCPNumber: RawRepresentable, Codable, Sendable, ExpressibleByIntegerLiteral, LosslessStringConvertible
    {
        public let rawValue: Int

        public init?(rawValue: Int)
        {
            guard rawValue >= 0 else { return nil }
            self.rawValue = rawValue
        }

        public init?(_ description: String)
        {
            guard let convertedString = Int(description)
            else
            {
                return nil
            }

            self.rawValue = convertedString
        }

        public init(integerLiteral value: Int)
        {
            self.rawValue = value
        }

        init(_ value: Int)
        {
            self.rawValue = .init(integerLiteral: value)
        }

        public var description: String
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
            return baseURLForLoading.appending(component: "scp-\(number)")
        case .tale(let address):
            return baseURLForLoading.appending(component: address)
        }
    }

    public var description: String
    {
        switch self
        {
        case .scp(let scpNumber):
            return "SCP-\(scpNumber.description)"
        case .tale(let taleAddress):
            return "Tale: \(taleAddress)"
        }
    }
}

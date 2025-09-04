//
//  App Constants.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation
import OSLog

public final class AppConstants: Sendable
{
    public static let shared: AppConstants = .init()
    
    public let logger: Logger
    
    public init()
    {
        self.logger = .init(subsystem: "eu.rikidar.foundation-terminal", category: "general")
    }
}

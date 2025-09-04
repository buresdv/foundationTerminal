//
//  Library Constants.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
import OSLog

struct LibraryConstants
{
    static let shared: LibraryConstants = .init()
    
    let logger: Logger = .init(subsystem: "eu.rikidar.foundation-terminal", category: "html-parser")
}

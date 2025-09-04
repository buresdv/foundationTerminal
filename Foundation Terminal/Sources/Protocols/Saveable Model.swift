//
//  Saveable Model.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Foundation
import SwiftUI

protocol SaveableModel: Sendable
{
    var modelDesctiption: LocalizedStringKey { get }
}

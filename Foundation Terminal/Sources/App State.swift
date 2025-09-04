//
//  App State.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 02.09.2025.
//

import Observation
import SwiftUI

@Observable
final class AppState
{
    var alertManager: AlertManager
    var sheetManager: SheetManager
    
    enum StartpageState
    {
        case setUp
        case fatalError
    }

    var startpageState: StartpageState
    
    init()
    {
        self.alertManager = .init()
        self.sheetManager = .init()
        
        self.startpageState = .setUp
    }
}

// MARK: - Navigation Manager
extension AppState
{
    @Observable
    final class NavigationManager
    {
        var navigationPath: NavigationPath
        
        init(navigationPath: NavigationPath)
        {
            self.navigationPath = navigationPath
        }
    }
}

extension AppState.NavigationManager
{
    func navigate(to destination: NavigationDestination)
    {
        self.navigationPath.append(destination)
    }
    
    func goBack()
    {
        self.navigationPath.removeLast()
    }
    
    func popToRoot()
    {
        self.navigationPath = .init()
    }
}

// MARK: - Sheet Manager
extension AppState
{
    @Observable
    final class SheetManager
    {
        var sheetToShow: DisplayableSheet?
    }
}

extension AppState.SheetManager
{
    func showSheet(_ sheetType: DisplayableSheet)
    {
        self.sheetToShow = sheetType
    }
    
    func dismissSheet()
    {
        self.sheetToShow = nil
    }
}

// MARK: - Alert Manager
extension AppState
{
    @Observable
    final class AlertManager
    {
        var isShowingAlert: Bool
        
        var alertToShow: DisplayableAlert?

        init()
        {
            self.isShowingAlert = false
            self.alertToShow = nil
        }
    }
}

extension AppState.AlertManager
{
    func showAlert(_ alertToShow: DisplayableAlert) -> Void
    {
        self.alertToShow = alertToShow
        self.isShowingAlert = true
    }
    
    func dismissAlert() -> Void
    {
        self.isShowingAlert = false
        self.alertToShow = nil
    }
}

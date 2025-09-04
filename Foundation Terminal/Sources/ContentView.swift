import SwiftUI

public struct ContentView: View
{
    @Environment(AppState.self) var appState: AppState

    public var body: some View
    {
        StartPage()
            .alertSetupTask(of: self, alertManager: appState.alertManager)
            .sheetSetupTask(of: self, sheetManager: appState.sheetManager)
    }
}

private extension View
{
    func alertSetupTask(of _: ContentView, alertManager: AppState.AlertManager) -> some View
    {
        self
            .alert(isPresented: Bindable(alertManager).isShowingAlert, error: alertManager.alertToShow)
            { displayedError in
                switch displayedError
                {
                case .failedToInitializePersistenceContainer:
                    EmptyView()
                }
            } message: { displayedError in
                if let recoverySuggestion = displayedError.recoverySuggestion
                {
                    Text(recoverySuggestion)
                }
            }
    }
}

private extension View
{
    func sheetSetupTask(of _: ContentView, sheetManager: AppState.SheetManager) -> some View
    {
        self
            .sheet(item: Bindable(sheetManager).sheetToShow)
            { sheetToShow in
                switch sheetToShow
                {
                case .addArticle:
                    AddArticleView()
                case .editArticle(let articleToEdit):
                    Text("Edit \(articleToEdit.articleLink)")
                }
            }
    }
}

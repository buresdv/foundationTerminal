import FoundationTerminalShared
import SwiftUI
import SwiftData

public struct ContentView: View
{
    @Environment(AppState.self) var appState: AppState

    @Environment(\.modelContext) var modelContext: ModelContext
    
    @State private var isShowingSwiftDataDeletionConfirmation: Bool = false

    @Observable
    final class SwiftDataDeletionManager
    {
        var isShowingDeletionConfirmation: Bool = false
    }

    @State private var swiftDataDeletionManager: SwiftDataDeletionManager = .init()

    public var body: some View
    {
        StartPage()
            .confirmationDialog("delete-swift-data.confirmation.title", isPresented: Bindable(swiftDataDeletionManager).isShowingDeletionConfirmation)
            {
                Button(role: .destructive)
                {
                    AppConstants.shared.logger.info("Will purge SwiftData")
                    
                    try? modelContext.delete(model: Article.self)
                    try? modelContext.delete(model: SavedArticleCategory.self)
                } label: {
                    Text("action.delete-swift-data")
                }

                Button(role: .cancel)
                {
                    swiftDataDeletionManager.isShowingDeletionConfirmation = false
                } label: {
                    Text("action.cancel")
                }
            } message: {
                Text("delete-swift-data.confirmation.message")
            }
            .alertSetupTask(
                of: self,
                alertManager: appState.alertManager,
                swiftDataDeletionManager: swiftDataDeletionManager
            )
            .sheetSetupTask(
                of: self,
                sheetManager: appState.sheetManager
            )
    }
}

private extension View
{
    func alertSetupTask(
        of _: ContentView,
        alertManager: AppState.AlertManager,
        swiftDataDeletionManager: ContentView.SwiftDataDeletionManager
    ) -> some View
    {
        self
            .alert(isPresented: Bindable(alertManager).isShowingAlert, error: alertManager.alertToShow)
            { displayedError in
                switch displayedError
                {
                case .failedToInitializePersistenceContainer:
                    Button(role: .destructive)
                    {
                        swiftDataDeletionManager.isShowingDeletionConfirmation = true
                    } label: {
                        Text("action.delete-swift-data")
                    }

                case .failedToLoadArticleDetails:
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

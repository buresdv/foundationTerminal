import SwiftData
import SwiftUI
import FoundationTerminalShared

extension EnvironmentValues
{
    @Entry var articleManager: ArticleManager = .init()
    @Entry var terminalHTMLParser: TerminalHTMLParser = .init()
}

@main
struct FoundationTerminalApp: App
{
    @State var appState: AppState = .init()
    
    let articleManager: ArticleManager = .init()
    let terminalHTMLParser: TerminalHTMLParser = .init()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
        .environment(appState)
        .environment(\.articleManager, articleManager)
        .environment(\.terminalHTMLParser, terminalHTMLParser)
        .modelContainer(
            for: SavedArticleCategory.self,
            inMemory: false,
            isAutosaveEnabled: true,
            isUndoEnabled: true
        )
        { initializationResult in
            switch initializationResult {
            case .success(_):
                AppConstants.shared.logger.info("Successfully initialized model container for Articles")
            case .failure(let failure):
                AppConstants.shared.logger.error("Failed to initialize model container for Articles: \(failure.localizedDescription)")
                
                appState.alertManager.showAlert(.failedToInitializePersistenceContainer(modelDescription: "model.article.description", error: failure))
                
                appState.startpageState = .fatalError
            }
        }
    }
}

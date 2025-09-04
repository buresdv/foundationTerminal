//
//  Load Article.swift
//  Foundation Terminal
//
//  Created by David Bureš - P on 04.09.2025.
//

import Foundation
import FoundationTerminalShared

extension ArticleManager
{    
    /// Errors that might occur during the loading of data from the wiki
    enum DataLoadingError: LocalizedError
    {
        case encodingFailed(error: String)
        case invalidStatusCode(statusCode: Int)
        case requestFailed(error: String)
        case pageDoesNotExist
        case otherError(error: String)
    }

    func loadDataFromWiki(
        _ whatToLoad: ArticleType,
        isLoadingTracker: UnsafeMutablePointer<Bool>? = nil
    ) async throws(DataLoadingError) -> Data
    {
        defer
        {
            isLoadingTracker?.pointee = false
        }
        
        // Create the session configuration for data loading, using the default configuration
        let sessionConfiguration: URLSessionConfiguration = .default

        // Create the actual session from the above-specified configuration
        let session: URLSession = .init(configuration: sessionConfiguration)

        // Define the request that will be used to load data from the URL specified above
        let request: URLRequest = .init(url: whatToLoad.fullArticleURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)

        do
        {
            // Try to load the actual data
            let (data, response) = try await session.data(for: request)
            
            // Check if the status code is possible to be converted into usable status
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else
            {
                throw DataLoadingError.invalidStatusCode(statusCode: -1)
            }
            
            // Check if that page actually exists
            guard statusCode != 404 else
            {
                throw DataLoadingError.pageDoesNotExist
            }
            
            // Check for the usual bad status codes
            guard (200...299).contains(statusCode) else
            {
                throw DataLoadingError.invalidStatusCode(statusCode: statusCode)
            }
            
            // Return the loaded data
            return data
        }
        catch let error as EncodingError
        {
            throw .encodingFailed(error: error.localizedDescription)
        }
        catch let error as URLError
        {
            throw .requestFailed(error: error.localizedDescription)
        }
        catch let error as DataLoadingError
        {
            throw error
        }
        catch
        {
            throw .otherError(error: error.localizedDescription)
        }
    }
}

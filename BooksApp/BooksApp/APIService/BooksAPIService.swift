//
//  BooksAPIService.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation


/// Protocol used for dependancy injection
protocol BooksServiceProtocol {
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void))
}

/// Enum for book service endpoints
enum BooServiceEndpoints {
    case getBooks
}

/// Extension for book service request
extension BooServiceEndpoints: HTTPRequest {
    var path: String {
        switch self {
        case .getBooks:
            return "/v3/48d1cc9f-b6be-42ec-9c69-81787a391b98"
        }
    }
}

/// API service layer
struct BooksAPIService: BooksServiceProtocol {
    /// Function to get list of books
    /// - Parameters:
    ///   - endPoint: api end point url
    ///   - completionHandler: returns result types which includes success(Books) and failure data
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void)) {
        let urlRequest = BooServiceEndpoints.getBooks
        NetworkManager.shared.excute(with: urlRequest, type: Books.self) { result in
            switch result {
            case .success(let result):
                completionHandler(.success(result))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

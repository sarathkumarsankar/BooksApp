//
//  APIService.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation

/// Protocol used for dependancy injection
protocol BooksServiceProtocol {
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void))
}

/// API service layer
struct APIService: BooksServiceProtocol {
    /// Function to get list of books
    /// - Parameters:
    ///   - endPoint: api end point url
    ///   - completionHandler: returns result types which includes success(Books) and failure data
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void)) {
        guard let url = URL(string: BooksAPIConstants.baseUrl + endPoint.rawValue) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        NetworkManager.shared.excute(_urlRequest: urlRequest, type: Books.self) { result in
            switch result {
            case .success(let result):
                completionHandler(.success(result))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

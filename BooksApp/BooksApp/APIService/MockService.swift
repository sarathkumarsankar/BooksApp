//
//  MockService.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation

/// Mock service
struct MockService: BooksServiceProtocol {
    /// Function to get list of books from  mock json
    /// - Parameters:
    ///   - endPoint:api end point url
    ///   - completionHandler: returns result types which includes success(Books) and failure data
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void)) {
        guard
             let url = Bundle.main.url(forResource: "books", withExtension: "json"),
             let data = try? Data(contentsOf: url)
        else {
             return
        }
        NetworkManager.shared.decode(data, completionHandler: completionHandler)
    }
}

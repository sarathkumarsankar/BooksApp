//
//  BooksMockService.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation
@testable import BooksApp

enum ResponseFileName: String {
    case success = "books"
    case failure = "books_error"
    case noData = "books_empty"
}
/// Mock service
class BooksMockService: BooksServiceProtocol {
    private(set) var isBooksServiceMethodCalled = false
    var responseFileName: ResponseFileName?
    
    init(responseFileName: ResponseFileName?) {
        self.responseFileName = responseFileName
    }
    /// Function to get list of books from  mock json
    /// - Parameters:
    ///   - endPoint:api end point url
    ///   - completionHandler: returns result types which includes success(Books) and failure data
    func booksService(endPoint: Endpoint, completionHandler: @escaping ((Result<Books, NetworkError>) -> Void)) {
        isBooksServiceMethodCalled = true
        guard
            let url = Bundle.main.url(forResource: responseFileName?.rawValue, withExtension: "json"),
             let data = try? Data(contentsOf: url)
        else {
             completionHandler(.failure(.unknown))
             return
        }
        NetworkManager.shared.decode(data, completionHandler: completionHandler)
    }
}

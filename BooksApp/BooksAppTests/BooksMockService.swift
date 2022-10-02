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
    /// variable for caching downlaoded images
    private let imageCache = NSCache<NSString, NSData>()
    var responseFileName: ResponseFileName?
    
    private(set) var isBooksServiceMethodCalled = false
    private(set) var isImageServiceMethodCalled = false

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
             completionHandler(.failure(.somethingWentWrong))
             return
        }
        NetworkManager.shared.decode(data, completionHandler: completionHandler)
    }
    
    /// mock image service
    /// - Parameters:
    ///   - urlString: image url
    ///   - completionHandler: returns result types which includes success(image) and failure data
    func downloadImageService(withUrl urlString: String, completionHandler: @escaping ((Result<Data, NetworkError>) -> Void)) {
        isImageServiceMethodCalled = true
        guard URL(string: urlString) != nil else {
            completionHandler(.failure(.invalidURL))
            return
        }
        /// check image already available in cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completionHandler(.success(cachedImage as Data))
            return
        }
        guard let data = urlString.data(using: .utf8) else {
            completionHandler(.failure(.responseError))
            return
        }
        
        /// store image in cache
        self.imageCache.setObject(data as NSData, forKey: urlString as NSString)
        completionHandler(.success(data))
    }

}

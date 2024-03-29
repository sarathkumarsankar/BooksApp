//
//  BooksAPIService.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation

/// Protocol used for dependancy injection
protocol BooksServiceProtocol {
    func booksService(completionHandler: @escaping ((Result<Books, NetworkError>) -> Void))
    func downloadImageService(withUrl urlString: String, completionHandler: @escaping ((Result<Data, NetworkError>) -> Void))
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
            return "/v3/98bd191b-c63a-40b0-acbe-1fa0b5d1ab47"
        }
    }
}

/// API service layer
struct BooksAPIService: BooksServiceProtocol {
    /// variable for caching downlaoded images
    private let imageCache = NSCache<NSString, NSData>()

    /// Function to get list of books
    /// - Parameters:
    ///   - endPoint: api end point url
    ///   - completionHandler: returns result types which includes success(Books) and failure data
    func booksService(completionHandler: @escaping ((Result<Books, NetworkError>) -> Void)) {
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
    
    /// download image and save to cache
    /// - Parameters:
    ///   - urlString: image url sting
    ///   - completionHandler: result type which includes success(image data) and error
    func downloadImageService(withUrl urlString: String, completionHandler: @escaping ((Result<Data, NetworkError>) -> Void)) {
        /// check image already available in cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completionHandler(.success(cachedImage as Data))
            return
        }
        NetworkManager.shared.downloadImage(withUrl: urlString) { result in
            switch result {
            case .success(let data):
                /// store image in cache
                self.imageCache.setObject(data as NSData, forKey: urlString as NSString)
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}

//
//  NetworkManager.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

/// Enum for api end points
enum Endpoint: String {
    case books = "4e6a999c-813b-4e86-9af9-a47a7d82301e"
}

/// Enum for possible error cases
enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case decodeError
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseError:
            return "Invalid response"
        case .unknown:
            return "Unknown error"
        case .decodeError:
            return "Decode error"
        }
    }
}

/// Singleton class for Netwoking
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
    }    
    
    /// function used to call the api
    /// - Parameters:
    ///   - _urlRequest: Url request(headers, http method)
    ///   - type: Place holder for model type
    ///   - completionHandler: result types which includes success and failure data
     func excute<T : Decodable>(_urlRequest: URLRequest, type: T.Type, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: _urlRequest) { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(.failure(NetworkError.responseError))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(.failure(NetworkError.responseError))
                return
            }
            
            self.decode(data, completionHandler: completionHandler)
        }
        dataTask.resume()
    }
    
    /// Generic func to parse the response data into model
    /// - Parameters:
    ///   - data: response data from api
    ///   - completionHandler: result types which includes success and failure data
    func decode<T: Decodable>(_ data: Data, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(model))
        } catch {
            completionHandler(.failure(NetworkError.decodeError))
        }
    }
    
}

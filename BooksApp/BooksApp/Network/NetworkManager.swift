//
//  NetworkManager.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

/// Enum for api end points
enum Endpoint: String {
    case books = "48d1cc9f-b6be-42ec-9c69-81787a391b98"
}

/// Enum for possible error cases
enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case decodeError
}

extension NetworkError {
    /// Error message
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
     func excute<T : Decodable>(with endpoint: HTTPRequest, type: T.Type, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        let urlSession = URLSession.shared
        
         var components = URLComponents()
         components.scheme = endpoint.scheme
         components.host = endpoint.baseURL
         components.path = endpoint.path
         components.queryItems = endpoint.parameters

         guard let url = components.url else {
             completionHandler(.failure(NetworkError.invalidURL))
             return
         }

         var urlRequest = URLRequest(url: url)
         urlRequest.httpMethod = endpoint.method
         urlRequest.httpBody = endpoint.data

         endpoint.headers?.forEach { urlRequest.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }

        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
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
}

extension NetworkManager {
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

//
//  NetworkManager.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

enum Endpoint: String {
    case books = "4e6a999c-813b-4e86-9af9-a47a7d82301e"
}

enum APIerror: Error {
    case serviceError
    case decodeError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://run.mocky.io/v3/"
    
    private init() {
    }    
   
    private func excute<T : Decodable>(_urlRequest: URLRequest, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: _urlRequest) { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(.failure(APIerror.serviceError))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(.failure(APIerror.serviceError))
                return
            }
            
            self.decode(data, completionHandler: completionHandler)
        }
        dataTask.resume()
    }
    
    private func decode<T: Decodable>(_ data: Data, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(model))
        } catch {
            completionHandler(.failure(APIerror.decodeError))
        }
    }
    
}

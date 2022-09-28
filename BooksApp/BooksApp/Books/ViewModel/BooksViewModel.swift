//
//  BooksViewModel.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import UIKit

/// View model for books View
class BooksViewModel {
    
    private let serviceManager: BooksServiceProtocol?
    var errorMessage: Observable<String?> = Observable(nil)
    var books: Observable<[Book]> = Observable([])

    // We can now inject a "mocked" version of service for unit tests.
    // This "mocked" version will confirm to BooksServiceProtocol which we created earlier.
    init(serviceManager: BooksServiceProtocol = APIService()) {
        self.serviceManager = serviceManager
    }
    
    /// Get the books list from API
    func getBooks() {
        serviceManager?.booksService(endPoint: .books, completionHandler: { result in
            switch result {
            case .success(let result):
                self.books.value = result.books ?? []
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        })
    }
    
}

//
//  BooksViewModel.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

/// View model for books View
class BooksViewModel {
    
    private let serviceManager: BooksServiceProtocol?
    var error: Observable<String?> = Observable(nil)
    var booksCellViewModels: Observable<[BooksCellViewModel]> = Observable([])
    
    // We can now inject a "mocked" version of service for unit tests.
    init(serviceManager: BooksServiceProtocol = BooksAPIService()) {
        self.serviceManager = serviceManager
    }
    
    /// Get the books list from API
    func getBooks() {
        serviceManager?.booksService(endPoint: .books, completionHandler: { result in
            switch result {
            case .success(let result):
                ///Map books into array  of cell viewModel
                self.booksCellViewModels.value = result.books?.map { BooksCellViewModel(with: $0) } ?? []
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        })
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BooksCellViewModel {
        return booksCellViewModels.value[indexPath.row]
    }

}

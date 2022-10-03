//
//  BooksViewModel.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import Foundation

/// View model for books View
final class BooksViewModel {
    
    private let serviceManager: BooksServiceProtocol?
    var error: Observable<String?> = Observable(nil)
    var booksCellViewModels: Observable<[BooksDataViewModel]> = Observable([])
    
    // initializer
    init(serviceManager: BooksServiceProtocol = BooksAPIService()) {
        self.serviceManager = serviceManager
    }
    
    /// Get the books list from API
    func getBooks() {
        serviceManager?.booksService(completionHandler: { result in
            switch result {
            case .success(let result):
                ///Map books into array  of cell viewModel
                self.booksCellViewModels.value = result.books?.map { BooksDataViewModel(with: $0) } ?? []
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        })
    }
    
    /// returns cellViewModel based on tableview indexpath
    /// - Parameter indexPath: Indexpath
    /// - Returns: cell ciew model
    func getCellViewModel(at indexPath: IndexPath) -> BooksDataViewModel {
        return booksCellViewModels.value[indexPath.row]
    }

}

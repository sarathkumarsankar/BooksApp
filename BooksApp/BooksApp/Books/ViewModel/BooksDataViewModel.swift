//
//  BooksTableViewCellViewModel.swift
//  BooksApp
//
//  Created by SarathKumar S on 29/09/22.
//

import Foundation

/// used this delegate to pass the data from dataviewmodel to view
protocol BooksDataViewModelDelegate: AnyObject {
    func didImageDownload(data: Data?, error: String?)
}

/// View model for books  View
class BooksDataViewModel {
    private let serviceManager: BooksServiceProtocol?
    weak var delegate: BooksDataViewModelDelegate?
    let book: Book?

    init(with book: Book, serviceManager: BooksServiceProtocol = BooksAPIService()) {
        self.book = book
        self.serviceManager = serviceManager
    }
    
    var title: String {
        return self.book?.bookName ?? ""
    }
    
    var subtitle: String {
        return self.book?.description ?? ""
    }
    
    var author: String {
        return self.book?.author ?? ""
    }

    var imageUrString: String {
        return self.book?.image ?? ""
    }

    func showImage() {
        guard let urlString = self.book?.image else { return }
        serviceManager?.downloadImageService(withUrl: urlString, completionHandler: { result in
            switch result {
            case .success(let data):
                self.delegate?.didImageDownload(data: data, error: nil)
            case .failure(let error):
                self.delegate?.didImageDownload(data: nil, error: error.errorDescription)
            }
        })
    }
}

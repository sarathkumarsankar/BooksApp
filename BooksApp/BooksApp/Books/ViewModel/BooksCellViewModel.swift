//
//  BooksTableViewCellViewModel.swift
//  BooksApp
//
//  Created by SarathKumar S on 29/09/22.
//

import Foundation
import UIKit

/// View model for books cell View
class BooksCellViewModel {
    
    let book: Book?
    
    init(with book: Book) {
        self.book = book
    }
    
    var title: String {
        return self.book?.bookName ?? ""
    }
    
    var subtitle: String {
        return self.book?.description ?? ""
    }
    
    var image: String {
        return self.book?.image ?? ""
    }

}

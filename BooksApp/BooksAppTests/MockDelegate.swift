//
//  MockDelegate.swift
//  BooksAppTests
//
//  Created by SarathKumar S on 02/10/22.
//

import Foundation
@testable import BooksApp

class MockDelegate: BooksDataViewModelDelegate {
    var delegateMethodCalled = false
    var imageData: Data?
    var error: String?

    func didImageDownload(data: Data?, error: String?) {
        delegateMethodCalled = true
        imageData = data
        self.error = error
    }
    
}

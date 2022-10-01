//
//  BooksViewModelTests.swift
//  BooksAppTests
//
//  Created by SarathKumar S on 28/09/22.
//

import XCTest
@testable import BooksApp

class BooksViewModelTests: XCTestCase {
    
    var booksViewModel: BooksViewModel?
    var bookServiceManager: BooksMockService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        booksViewModel = nil
        bookServiceManager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Test mock service
    func testGetBooks() {
        bookServiceManager = BooksMockService(responseFileName: .success)
        booksViewModel = BooksViewModel(serviceManager: bookServiceManager)
        booksViewModel?.getBooks()
        XCTAssertTrue(bookServiceManager.isBooksServiceMethodCalled, "bookServiceManager method should be called.")
        booksViewModel?.booksCellViewModels.bind { booksCellViewModel in
            XCTAssertEqual(booksCellViewModel.count, 6, "its should equal to mock data of count 6")
            XCTAssertNotNil(booksCellViewModel[0].title)
            XCTAssertNotNil(booksCellViewModel[0].subtitle)
        }
    }
    
    /// Test mock service failure case
    func testGetBooksFailureCase() {
        bookServiceManager = BooksMockService(responseFileName: .failure)
        booksViewModel = BooksViewModel(serviceManager: bookServiceManager)
        booksViewModel?.getBooks()
        XCTAssertTrue(bookServiceManager.isBooksServiceMethodCalled, "bookServiceManager method should be called.")
        booksViewModel?.error.bind { error in
            XCTAssertNotNil(error)
        }
    }
    
    /// Test empty mock response
    func testGetEmptyResponse() {
        bookServiceManager = BooksMockService(responseFileName: .noData)
        booksViewModel = BooksViewModel(serviceManager: bookServiceManager)
        booksViewModel?.getBooks()
        XCTAssertTrue(bookServiceManager.isBooksServiceMethodCalled, "bookServiceManager method should be called.")
        booksViewModel?.booksCellViewModels.bind { booksCellViewModel in
            XCTAssertEqual(booksCellViewModel.count, 0, "it should be no data")
        }
    }
    
    /// Test success mock response data
    func testBooksData() {
        bookServiceManager = BooksMockService(responseFileName: .success)
        booksViewModel = BooksViewModel(serviceManager: bookServiceManager)
        booksViewModel?.getBooks()
        XCTAssertTrue(bookServiceManager.isBooksServiceMethodCalled, "bookServiceManager method should be called.")
        booksViewModel?.booksCellViewModels.bind { booksCellViewModel in
            
            XCTAssertEqual(booksCellViewModel[0].title, "The India Story")
            XCTAssertEqual(booksCellViewModel[0].subtitle, "Over a period of five years, The India Story has grown to become one of the hippest cultural events in Kolkata.")

        }
    }
}

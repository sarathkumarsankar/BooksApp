//
//  BooksDataViewModelTests.swift
//  BooksAppTests
//
//  Created by SarathKumar S on 02/10/22.
//

import XCTest
@testable import BooksApp

class BooksDataViewModelTests: XCTestCase {
    var booksCellViewModel: BooksDataViewModel?
    var bookServiceManager: BooksMockService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        booksCellViewModel = nil
        bookServiceManager = nil
    }
    
    /// Test cell view model returns correct data
    func testViewModelReturnsCorrectData() {
        bookServiceManager = BooksMockService(responseFileName: .success)
        let book = Book(bookId: "1", bookName: "the moon boy", publishedDate: "02-11-2022", author: "hacward stanly", description: "it is precious book of the year", image: "https://png.pngtree.com/png-vector/20220412/ourmid/pngtree-toga-hat-on-books-with-black-brown-color-png-image_4539288.png")
        booksCellViewModel = BooksDataViewModel(with: book, serviceManager: bookServiceManager)
        
        XCTAssertEqual(booksCellViewModel?.title, "the moon boy")
        XCTAssertEqual(booksCellViewModel?.subtitle, "it is precious book of the year")
        XCTAssertEqual(booksCellViewModel?.imageUrString, "https://png.pngtree.com/png-vector/20220412/ourmid/pngtree-toga-hat-on-books-with-black-brown-color-png-image_4539288.png")

    }
    
    /// Test cellview model retunn epty data if value is nil
    func testViewModelReturnsEmptyData() {
        bookServiceManager = BooksMockService(responseFileName: .success)
        let book = Book(bookId: "1", bookName: nil, publishedDate: "02-11-2022", author: "hacward stanly", description: nil, image: nil)
        booksCellViewModel = BooksDataViewModel(with: book, serviceManager: bookServiceManager)
        
        XCTAssertEqual(booksCellViewModel?.title, "")
        XCTAssertEqual(booksCellViewModel?.subtitle, "")
        XCTAssertEqual(booksCellViewModel?.imageUrString, "")

    }
    
    /// Test cell has called image download servcei
    func testImageDownloadService() {
        let requestExpectation = expectation(description: "Request should call image download service")
        bookServiceManager = BooksMockService(responseFileName: .success)
        let book = Book(bookId: "1", bookName: "the moon boy", publishedDate: "02-11-2022", author: "hacward stanly", description: "it is precious book of the year", image: "https://png.pngtree.com/png-vector/20220412/ourmid/pngtree-toga-hat-on-books-with-black-brown-color-png-image_4539288.png")
        booksCellViewModel = BooksDataViewModel(with: book, serviceManager: bookServiceManager)
        booksCellViewModel?.showImage()
        XCTAssertEqual(bookServiceManager.isImageServiceMethodCalled, true)
        requestExpectation.fulfill()
        wait(for: [requestExpectation], timeout: 3)
    }
    
    /// Test  delegate method triggered or not, and cache
    func testDelegateMethodAndCache() {
        let urlString = "https://png.pngtree.com/png-vector/20220412/ourmid/pngtree-toga-hat-on-books-with-black-brown-color-png-image_4539288.png"
        bookServiceManager = BooksMockService(responseFileName: .success)
        let book = Book(bookId: "1", bookName: "the moon boy", publishedDate: "02-11-2022", author: "hacward stanly", description: "it is precious book of the year", image: urlString)
        let viewModel = BooksDataViewModel(with: book, serviceManager: bookServiceManager)
        let data = urlString.data(using: .utf8)
        let mockDelegate = MockDelegate()
        
        let delegateExpectation = expectation(description: "Delegate method should be called")
        viewModel.delegate = mockDelegate
        viewModel.showImage()
        XCTAssertTrue(mockDelegate.delegateMethodCalled)
        XCTAssertEqual(data, mockDelegate.imageData)
        XCTAssertNil(mockDelegate.error)
        delegateExpectation.fulfill()
        wait(for: [delegateExpectation], timeout: 3)
        
        let delegateExpectation1 = expectation(description: "Cache image should return correct data")
        viewModel.delegate = mockDelegate
        viewModel.showImage()
        XCTAssertTrue(mockDelegate.delegateMethodCalled)
        XCTAssertEqual(data, mockDelegate.imageData)
        XCTAssertNil(mockDelegate.error)
        delegateExpectation1.fulfill()
        wait(for: [delegateExpectation1], timeout: 3)

    }
    
    func testInvalideUrl() {
        let urlString = ""
        bookServiceManager = BooksMockService(responseFileName: .success)
        let book = Book(bookId: "1", bookName: "the moon boy", publishedDate: "02-11-2022", author: "hacward stanly", description: "it is precious book of the year", image: urlString)
        let viewModel = BooksDataViewModel(with: book, serviceManager: bookServiceManager)
        let mockDelegate = MockDelegate()

        let expectation = expectation(description: "is should return invalide url")
        viewModel.delegate = mockDelegate
        viewModel.showImage()
        XCTAssertTrue(mockDelegate.delegateMethodCalled)
        XCTAssertNotNil(mockDelegate.error)
        XCTAssertEqual("Invalid URL", mockDelegate.error)
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
}



//
//  BookDetailViewController.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import UIKit

final class BookDetailViewController: UIViewController {
    /// Private outlets
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    /// variable to hold passed data model
    var bookData: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.setRoundCornerImage()
        updateUI()
    }
    
    /// update ui based on selected book
    private func updateUI() {
        guard let book = bookData else {
            return
        }
        self.title = book.bookName
        self.nameLabel.text = book.bookName
        self.descriptionLabel.text = book.description
        self.authorLabel.text = book.author
        self.descriptionLabel.text = book.description
        if let image = book.image {
            self.bookImageView.setImageUsingCache(withUrl: image)
        }
    }
}

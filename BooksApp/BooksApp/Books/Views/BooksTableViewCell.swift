//
//  BooksTableViewCell.swift
//  BooksApp
//
//  Created by SarathKumar S on 28/09/22.
//

import UIKit

final class BooksTableViewCell: UITableViewCell {
    
    /// Private outlets
    @IBOutlet private weak var booksImageView: UIImageView!
    @IBOutlet private weak var bookNameLabel: UILabel!
    @IBOutlet private weak var bookDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Update the cell
    /// - Parameter model: books model
    func configureCell(with model: Book) {
        bookNameLabel.text = model.bookName
        bookDescriptionLabel.text = model.text
        if let imageUrl = model.image {
            booksImageView.setImageUsingCache(withUrl: imageUrl)
        }
    }
}
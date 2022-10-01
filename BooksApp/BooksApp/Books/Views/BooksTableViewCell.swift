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
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configure cell with data
    /// - Parameter cellViewModel: BooksCell viewmodel
    func configureCell(cellViewModel: BooksCellViewModel?) {
        bookNameLabel.text = cellViewModel?.title
        bookDescriptionLabel.text = cellViewModel?.subtitle
        booksImageView.setImageUsingCache(withUrl: cellViewModel?.imageUrString)
    }
        
    private func initView() {
        booksImageView.setRoundCornerImage()
    }
    
}

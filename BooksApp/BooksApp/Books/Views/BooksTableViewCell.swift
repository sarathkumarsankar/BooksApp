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
    
    var cellViewModel: BooksCellViewModel? {
        didSet {
            bookNameLabel.text = cellViewModel?.title
            bookDescriptionLabel.text = cellViewModel?.subtitle
            if let imageUrl = cellViewModel?.image {
                booksImageView.setImageUsingCache(withUrl: imageUrl)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initView() {
        booksImageView.setRoundCornerImage()
    }
    
}

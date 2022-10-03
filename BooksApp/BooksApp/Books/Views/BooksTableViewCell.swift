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
    func configureCell(cellViewModel: BooksDataViewModel?) {
        bookNameLabel.text = cellViewModel?.title
        bookDescriptionLabel.text = cellViewModel?.subtitle
        cellViewModel?.delegate = self
        self.booksImageView.image = UIImage(named: ImageConstants.placeHolderImage.rawValue)
        cellViewModel?.showImage()
    }
        
    private func initView() {
        booksImageView.setRoundCornerImage()
    }
    
}

// MARK: BooksTableViewCell Delegate method
extension BooksTableViewCell: BooksDataViewModelDelegate {
    func didImageDownload(data: Data?, error: String?) {
        guard let data = data, let image = UIImage(data: data) else {
            return
        }
        DispatchQueue.main.async {
            self.booksImageView.image = image
        }
    }
}

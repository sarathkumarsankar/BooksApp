//
//  BooksViewController+Extension.swift
//  BooksApp
//
//  Created by SarathKumar S on 29/09/22.
//

import Foundation
import UIKit

// MARK: UITableView datasorce methods
extension BooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.booksCellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        TableViewCellIdentifier.booksTableViewCell) as?
                BooksTableViewCell else {
            return UITableViewCell()
        }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: UITableView Delegate methods
extension BooksViewController: UITableViewDelegate {
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.booksCellViewModels.value[indexPath.row].book
        let bookDetailViewController = BookDetailViewController.load(from: .main)
        bookDetailViewController.bookData = book
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}

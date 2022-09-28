//
//  BooksViewController.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import UIKit

final class BooksViewController: UIViewController {
    private let viewModel = BooksViewModel()
    @IBOutlet private weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUpTableView()
        viewModel.getBooks()
        addObservers()
    }
    
    /// set Ui
    private func setUI() {
        self.title = ViewControllerTitle.booksVC
    }
    
    /// Method for add observer to response and error
    private func addObservers() {
        viewModel.books.bind { books in
            DispatchQueue.main.async() {
                self.booksTableView.reloadData()
            }
        }
        viewModel.errorMessage.bind { error in
            if let error = error {
                DispatchQueue.main.async() {
                    self.showAlert(error)
                }
            }
        }
    }
    
    private func setUpTableView() {
        booksTableView.rowHeight = UITableView.automaticDimension
        booksTableView.estimatedRowHeight = 80
    }
}

// MARK: Delegate and datasorce methods
extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        TableViewCellIdentifier.booksTableViewCell) as?
                BooksTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: viewModel.books.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.books.value[indexPath.row]
        let bookDetailViewController = BookDetailViewController.load(from: .main)
        bookDetailViewController.bookData = book
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}

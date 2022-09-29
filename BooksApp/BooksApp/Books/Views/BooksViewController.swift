//
//  BooksViewController.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import UIKit

final class BooksViewController: UIViewController {
    var viewModel = BooksViewModel()
    @IBOutlet private weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
}


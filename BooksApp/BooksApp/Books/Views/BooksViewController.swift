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
    
    /// ViewController life cycle- Called after the view has been loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        viewModel.getBooks()
        addObservers()
    }
    
    /// update Ui
    private func updateUI() {
        self.title = ViewControllerTitle.booksVC
    }
    
    /// Method for add observer to response and error
    private func addObservers() {
        viewModel.booksCellViewModels.bind { books in
            DispatchQueue.main.async() {
                self.booksTableView.reloadData()
            }
        }
        viewModel.error.bind { error in
            if let error = error {
                DispatchQueue.main.async() {
                    self.showAlert(error)
                }
            }
        }
    }
}


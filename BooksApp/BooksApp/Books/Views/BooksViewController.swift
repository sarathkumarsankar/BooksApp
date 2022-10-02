//
//  BooksViewController.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 27/09/22.
//

import UIKit

final class BooksViewController: UIViewController {
    private var viewModel = BooksViewModel()
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
        self.title = NavigationBarTitle.booksVC
    }
    
    /// Method for add observer to response and error
    private func addObservers() {
        viewModel.booksCellViewModels.bind { _ in
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
        cell.configureCell(cellViewModel: viewModel.getCellViewModel(at: indexPath))
        return cell
    }
}

// MARK: UITableView Delegate methods
extension BooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel.booksCellViewModels.value[indexPath.row]
        let bookDetailViewController = BookDetailViewController.load(from: .main)
        bookDetailViewController.dataViewModel = viewModel
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}

//
//  HomeViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchViewController())
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Искать анализы"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: 55).isActive = true
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        }
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

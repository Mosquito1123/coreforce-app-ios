//
//  NotificationViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit

class NotificationViewController: UIViewController,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
}

// MARK: - Setup
private extension NotificationViewController {
    
    private func setupNavbar() {
        self.title = "消息通知"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "测试", style: .plain, target: self, action: #selector(searchTapped(_:)))
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension NotificationViewController {
    
}

// MARK: - Request
private extension NotificationViewController {
    
}

// MARK: - Action
@objc private extension NotificationViewController {
    @objc func searchTapped(_ sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension NotificationViewController {
    
}

//
//  RandomUsersListViewController.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol RandomUsersListViewControllerDelegate {
    func favouriteButtonClicked()
}

protocol RandomUsersListViewControllerDataSource {
    //settings
    func refreshIsEnabled() -> Bool
    func favouritesIsEnabled() -> Bool
    func rowSelectionEnabled() -> Bool
    func title() -> String
    
    func numberOfRows() -> Int
    func downloadNewUsers(success: @escaping () -> Void, failure: @escaping (NSError?) -> Void)
    func randomUserModelForIndex(index: Int) -> RandomUserModel
    func selectedRandomUser(index: Int)
    func deleteRandomUser(index: Int)
    func search(phrase: String)
    func refreshData()
}

class RandomUsersListViewController: UIViewController {

    // MARK: outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: properties
    var delegate: RandomUsersListViewControllerDelegate?
    var dataSource: RandomUsersListViewControllerDataSource?
    var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationItems()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RandomUsersListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "RandomUsersListCell")
        self.searchBar.delegate = self
        self.searchBar.autocapitalizationType = .none
        self.tableView.keyboardDismissMode = .onDrag
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingGesture))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!isFirstLoad) {
            self.dataSource!.refreshData()
            self.tableView.reloadData()
        } else {
            self.isFirstLoad = false
        }
    }
    
    func addNavigationItems() {
        self.title = self.dataSource!.title()
        var navigationItems = [UIBarButtonItem]()
        if self.dataSource!.favouritesIsEnabled() {
            let favouriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "BookmarkRibbonBlack"), style: .plain, target: self, action: #selector(favouritesClicked))
            navigationItems.append(favouriteButton)
        }
        
        if self.dataSource!.refreshIsEnabled() {
            let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Refresh"), style: .plain, target: self, action: #selector(refreshItems))
            navigationItems.append(refreshButton)
        }
        
        self.navigationItem.rightBarButtonItems = navigationItems
    }
    
    @objc func endEditingGesture() {
        self.view.endEditing(true)
    }
    
    @objc func refreshItems() {
        SVProgressHUD.show()
        self.dataSource?.downloadNewUsers(success: {
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }, failure: { (error) in
            SVProgressHUD.showError(withStatus: error?.localizedDescription)
            SVProgressHUD.dismiss(withDelay: TimeInterval(5.0))
        })
    }
    
    @objc func favouritesClicked() {
        self.delegate?.favouriteButtonClicked()
    }
}

extension RandomUsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomUsersListCell", for: indexPath) as! RandomUsersListTableViewCell
        let randomUser = self.dataSource!.randomUserModelForIndex(index: indexPath.row)
        cell.configure(with: randomUser)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.dataSource!.rowSelectionEnabled()) {
            self.dataSource!.selectedRandomUser(index: indexPath.row)
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dataSource!.deleteRandomUser(index: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension RandomUsersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.dataSource!.search(phrase: searchText)
        self.tableView.reloadData()
    }
}

extension RandomUsersListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}

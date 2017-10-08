//
//  HomeMenuViewController.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

protocol HomeMenuViewControllerDelegate {
    func randomUsersListClicked()
    func facouritedUsersClicked()
}

protocol HomeMenuViewControllerDataSource {
    
}

class HomeMenuViewController: UIViewController {
    // MARK: outlets
    
    
    // MARK: properties
    var delegate: HomeMenuViewControllerDelegate?
    var dataSource: HomeMenuViewControllerDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func randomUsersListClicked(_ sender: Any) {
        self.delegate?.randomUsersListClicked()
    }
    
    @IBAction func favouritedUsersClicked(_ sender: Any) {
        self.delegate?.facouritedUsersClicked()
    }
}

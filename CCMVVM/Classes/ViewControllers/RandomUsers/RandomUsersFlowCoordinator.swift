//
//  RandomUsersFlowCoordinator.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

protocol RandomUsersFlowCoordinatorDelegate {
    
}

class  RandomUsersFlowCoordinator: FlowCoordinator {
    var configure: FlowConfigure!
    
    var delegate: RandomUsersFlowCoordinatorDelegate?
    var isFavouritesList: Bool = false
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    func start() {
        if (isFavouritesList) {
            self.startFavourites()
        } else {
            self.startRandomList()
        }
    }
    
    fileprivate func startRandomList() {
        let viewController = UIStoryboard.viewControllerWithIdentifier(identifier: "RandomUsersListViewController", storyBoardName: "RandomUsers") as! RandomUsersListViewController
        viewController.delegate = self
        viewController.dataSource = RandomUsersListViewModel()
        self.configure.navigationController?.pushViewController(viewController, animated: true)
    }
    
    fileprivate func startFavourites() {
        let viewController = UIStoryboard.viewControllerWithIdentifier(identifier: "RandomUsersListViewController", storyBoardName: "RandomUsers") as! RandomUsersListViewController
        viewController.delegate = self
        viewController.dataSource = RandomUsersFavouriteListViewModel()
        self.configure.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RandomUsersFlowCoordinator: RandomUsersListViewControllerDelegate {
    func favouriteButtonClicked() {
        self.startFavourites()
    }
}

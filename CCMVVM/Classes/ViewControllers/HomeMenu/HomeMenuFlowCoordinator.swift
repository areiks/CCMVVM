//
//  HomeMenuFlowCoordinator.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

protocol HomeMenuFlowCoordinatorDelegate {
    
}

class  HomeMenuFlowCoordinator: FlowCoordinator {
    var configure: FlowConfigure!
    
    var delegate: HomeMenuFlowCoordinatorDelegate?
    var childFlowCoordinator: FlowCoordinator?
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    func start() {
        let viewController = UIStoryboard.viewControllerWithIdentifier(identifier: "HomeMenuViewController", storyBoardName: "HomeMenu") as! HomeMenuViewController
        viewController.delegate = self
        if let frame = configure.window?.bounds {
            viewController.view.frame = frame
        }
        self.configure.navigationController?.setViewControllers([viewController], animated: true)
    }
}

extension HomeMenuFlowCoordinator: HomeMenuViewControllerDelegate {
    func randomUsersListClicked() {
        let childFC = RandomUsersFlowCoordinator(configure: FlowConfigure(window: nil, navigationController: self.configure.navigationController, parent: self)) as RandomUsersFlowCoordinator
        childFC.isFavouritesList = false
        //childFC.delegate = self
        self.childFlowCoordinator = childFC
        self.childFlowCoordinator?.start()
    }
    
    func facouritedUsersClicked() {
        let childFC = RandomUsersFlowCoordinator(configure: FlowConfigure(window: nil, navigationController: self.configure.navigationController, parent: self)) as RandomUsersFlowCoordinator
        childFC.isFavouritesList = true
        //childFC.delegate = self
        self.childFlowCoordinator = childFC
        self.childFlowCoordinator?.start()
    }
}

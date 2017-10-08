//
//  MainFlowCoordinator.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit


class MainFlowCoordinator: FlowCoordinator {
    var configure: FlowConfigure!
    var mainNavigationController: UINavigationController?

    var childFlowCoordinator: FlowCoordinator?

    required init(configure: FlowConfigure) {
        self.configure = configure
    }

    func start() {
        // handle registered users here
        showMainFlow()
    }

    func showMainFlow() {
        
        let navVC = UINavigationController()
        configure.window?.rootViewController = navVC
        configure.window?.makeKeyAndVisible()
        self.mainNavigationController = navVC
        
        let childFC = HomeMenuFlowCoordinator(configure: FlowConfigure(window: nil, navigationController: self.mainNavigationController, parent: self))
        childFC.delegate = self
        self.childFlowCoordinator = childFC
        self.childFlowCoordinator?.start()
    }
}

extension MainFlowCoordinator: HomeMenuFlowCoordinatorDelegate {
    
}

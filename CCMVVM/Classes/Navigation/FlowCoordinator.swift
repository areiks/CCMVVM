//
//  FlowCoordinator.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

struct FlowConfigure {
    let window : UIWindow?
    let navigationController : UINavigationController?
    let parent : FlowCoordinator?
}

protocol FlowCoordinator {
    var configure: FlowConfigure! {get}
    init(configure : FlowConfigure)
    func start()
}

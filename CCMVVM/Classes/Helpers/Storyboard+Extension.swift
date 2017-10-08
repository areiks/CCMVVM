//
//  Storyboard+Extension.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class func viewControllerWithIdentifier(identifier:String, storyBoardName:String = "Main") -> UIViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

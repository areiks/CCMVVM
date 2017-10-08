//
//  Mappable.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import Foundation

protocol Mappable {
    
    init?(with jsonDictionary: [AnyHashable : Any])
}

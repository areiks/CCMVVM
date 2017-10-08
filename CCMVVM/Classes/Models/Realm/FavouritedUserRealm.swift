//
//  FavouritedUserRealm.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import RealmSwift

class FavouritedUserRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var favourited = false
}

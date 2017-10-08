//
//  RandomUserModel.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import Foundation

struct RandomUserModel: Mappable {
     // MARK: - JSON dictionary keys
    private static let nameKey = "name"
    private static let titleKey = "title"
    private static let firstNameKey = "first"
    private static let lastNameKey = "last"
    private static let emailKey = "email"
    
    // MARK: - api properties
    var title = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    
    // MARK: - local properties
    var favourited = false
    
    // MARK: - init
    init?(with jsonDictionary: [AnyHashable : Any]) {
        if let nameDict = jsonDictionary[RandomUserModel.nameKey] as? [AnyHashable : Any] {
            if let title = nameDict[RandomUserModel.titleKey] as? String {
                self.title = title
            }
            
            if let firstName = nameDict[RandomUserModel.firstNameKey] as? String {
                self.firstName = firstName
            }
            
            if let lastName = nameDict[RandomUserModel.lastNameKey] as? String {
                self.lastName = lastName
            }
        }
        
        if let email = jsonDictionary[RandomUserModel.emailKey] as? String {
            self.email = email
        }
    }
    
    init(with persistentModel: RandomUserRealm) {
        self.title = persistentModel.title
        self.firstName = persistentModel.firstName
        self.lastName = persistentModel.lastName
        self.email = persistentModel.email
        self.favourited = persistentModel.favourited
    }
    
    init(with favouriteModel: FavouritedUserRealm) {
        self.title = favouriteModel.title
        self.firstName = favouriteModel.firstName
        self.lastName = favouriteModel.lastName
        self.email = favouriteModel.email
        self.favourited = favouriteModel.favourited
    }
    
    // MARK: - static func
    
    static func jsonArrayToRandomUserModelArray(jsonArray: [[AnyHashable : Any]]) -> [RandomUserModel] {
        var usersArray = [RandomUserModel]()
        jsonArray.forEach({ (randomUser) in
            guard let randomUserModel = RandomUserModel(with: randomUser) else {
                return
            }
            usersArray.append(randomUserModel)
        })
        return usersArray
    }
    
    // MARK: - func
    
    func toPersistentModel() -> RandomUserRealm {
        let randomUserRealm = RandomUserRealm()
        randomUserRealm.title = self.title
        randomUserRealm.firstName = self.firstName
        randomUserRealm.lastName = self.lastName
        randomUserRealm.email = self.email
        randomUserRealm.favourited = self.favourited
        return randomUserRealm
    }
    
    func toFavouritedModel() -> FavouritedUserRealm {
        let favouritedUserRealm = FavouritedUserRealm()
        favouritedUserRealm.title = self.title
        favouritedUserRealm.firstName = self.firstName
        favouritedUserRealm.lastName = self.lastName
        favouritedUserRealm.email = self.email
        favouritedUserRealm.favourited = true
        return favouritedUserRealm
    }
}

extension RandomUserModel: Equatable {
    static func ==(left: RandomUserModel, right: RandomUserModel) -> Bool {
        return left.hashValue == right.hashValue
    }
}

extension RandomUserModel: Hashable {
    var hashValue: Int {
        get {
            return String(describing: email).hashValue
        }
    }
}

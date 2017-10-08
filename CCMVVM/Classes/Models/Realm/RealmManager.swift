//
//  RealmManager.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager: NSObject {
    // MARK: - Properties
    
    static let sharedInstance = RealmManager()
    
    // MARK: - Public methods
    
    // saves
    func storeArrayToRealm(array: [RandomUserModel]) {
        array.forEach { (randomUserModel) in
            let realm = try! Realm()
            let randomUserRealm = randomUserModel.toPersistentModel()
            try! realm.write {
                realm.add(randomUserRealm)
            }
        }
    }
    
    func favouriteUser(randomUser: RandomUserModel) {
        let realm = try! Realm()
        
        let randomUsers = realm.objects(RandomUserRealm.self).filter("email == %@", randomUser.email)
        
        guard randomUsers.count > 0 else {
            return
        }
        
        let randomUserRealm = randomUsers.first!
        let favouritedUserRealm = randomUser.toFavouritedModel()
        
        try! realm.write {
            randomUserRealm.favourited = true
            realm.add(favouritedUserRealm)
        }
    }
    
    func unfavouriteUser(randomUser: RandomUserModel) {
        let realm = try! Realm()
        
        let randomUsers = realm.objects(RandomUserRealm.self).filter("email == %@", randomUser.email)
        let favouritedUsers = realm.objects(FavouritedUserRealm.self).filter("email == %@", randomUser.email)
        
        guard randomUsers.count > 0 || favouritedUsers.count > 0 else {
            return
        }
        
        try! realm.write {
            if (randomUsers.count > 0) {
                let randomUserRealm = randomUsers.first!
                randomUserRealm.favourited = false
            }
            if (favouritedUsers.count > 0) {
                realm.delete(favouritedUsers.first!)
            }
        }
    }
    
    // gets
    func getCachedRandomUsers() -> [RandomUserModel] {
        let realm = try! Realm()
        let randomUsers = realm.objects(RandomUserRealm.self).sorted(byKeyPath: "lastName", ascending: true)
        var randomUserModels = [RandomUserModel]()
        randomUsers.forEach { (randomUserRealm) in
            let randomUserModel = RandomUserModel(with: randomUserRealm)
            randomUserModels.append(randomUserModel)
        }
        return randomUserModels
    }
    
    func getFavouritedUsers() -> [RandomUserModel] {
        let realm = try! Realm()
        let favouritedUsers = realm.objects(FavouritedUserRealm.self).sorted(byKeyPath: "lastName", ascending: true)
        var randomUserModels = [RandomUserModel]()
        favouritedUsers.forEach { (favouritedUserRealm) in
            let randomUserModel = RandomUserModel(with: favouritedUserRealm)
            randomUserModels.append(randomUserModel)
        }
        return randomUserModels
    }
    
    func getFilteredRandomUsers(searchPhrase: String) -> [RandomUserModel] {
        let realm = try! Realm()
        let randomUsers = realm.objects(RandomUserRealm.self).sorted(byKeyPath: "lastName", ascending: true)
            .filter("firstName CONTAINS %@ OR lastName CONTAINS %@ OR email CONTAINS %@", searchPhrase, searchPhrase, searchPhrase)
        var randomUserModels = [RandomUserModel]()
        randomUsers.forEach { (randomUserRealm) in
            let randomUserModel = RandomUserModel(with: randomUserRealm)
            randomUserModels.append(randomUserModel)
        }
        return randomUserModels
    }
    
    func getFilteredFavouritedUsers(searchPhrase: String) -> [RandomUserModel] {
        let realm = try! Realm()
        let favouritedUsers = realm.objects(FavouritedUserRealm.self).sorted(byKeyPath: "lastName", ascending: true)
                .filter("firstName CONTAINS %@ OR lastName CONTAINS %@ OR email CONTAINS %@", searchPhrase, searchPhrase, searchPhrase)
        var randomUserModels = [RandomUserModel]()
        favouritedUsers.forEach { (favouritedUserRealm) in
            let randomUserModel = RandomUserModel(with: favouritedUserRealm)
            randomUserModels.append(randomUserModel)
        }
        return randomUserModels
    }
    
    // deletes
    func deleteFavouritedUser(randomUser: RandomUserModel) {
        let realm = try! Realm()
        let favouritedUsers = realm.objects(FavouritedUserRealm.self).filter("email == %@", randomUser.email)
        
        guard favouritedUsers.count > 0 else {
            return
        }
        
        try! realm.write {
            realm.delete(favouritedUsers.first!)
        }
    }
    
    func deleteRandomUser(randomUser: RandomUserModel) {
        let realm = try! Realm()
        let randomUsers = realm.objects(RandomUserRealm.self).filter("email == %@", randomUser.email)
        
        guard randomUsers.count > 0 else {
            return
        }
        
        try! realm.write {
            realm.delete(randomUsers.first!)
        }
    }
    
    func clearCachedRandomUsers() {
        let realm = try! Realm()
        let randomUsers = realm.objects(RandomUserRealm.self)
        
        try! realm.write {
            realm.delete(randomUsers)
        }
    }
}

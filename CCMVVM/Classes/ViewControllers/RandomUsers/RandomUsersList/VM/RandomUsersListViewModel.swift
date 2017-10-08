//
//  RandomUsersListViewModel.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//
import Foundation

class RandomUsersListViewModel: RandomUsersListViewControllerDataSource {
    var usersArray = [RandomUserModel]()
    
    init() {
        self.usersArray = RealmManager.sharedInstance.getCachedRandomUsers()
    }
    
    // Settings
    func refreshIsEnabled() -> Bool {
        return true
    }
    
    func favouritesIsEnabled() -> Bool {
        return true
    }
    
    func rowSelectionEnabled() -> Bool {
        return true
    }
    
    func title() -> String {
        return "Random Users"
    }
    
    // TableView
    func numberOfRows() -> Int {
        return self.usersArray.count
    }
    
    func selectedRandomUser(index: Int) {
        guard index < usersArray.count else {
            return
        }
        
        let randomUser = usersArray[index]
        if (randomUser.favourited) {
            RealmManager.sharedInstance.unfavouriteUser(randomUser: usersArray[index])
        } else {
            RealmManager.sharedInstance.favouriteUser(randomUser: usersArray[index])
        }
        
        self.usersArray[index].favourited = !randomUser.favourited
    }
    
    func deleteRandomUser(index: Int) {
        guard index < usersArray.count else {
            return
        }
        
        RealmManager.sharedInstance.deleteRandomUser(randomUser: usersArray[index])
        self.usersArray.remove(at: index)
    }
    
    func randomUserModelForIndex(index: Int) -> RandomUserModel {
        return self.usersArray[index]
    }
    
    // actions
    
    func search(phrase: String) {
        self.usersArray = RealmManager.sharedInstance.getFilteredRandomUsers(searchPhrase: phrase)
    }
    
    func refreshData() {
        self.usersArray = RealmManager.sharedInstance.getCachedRandomUsers()
    }
    
    func downloadNewUsers(success: @escaping () -> Void, failure: @escaping (NSError?) -> Void) {
        APIManager.sharedInstance.getNewRandomUsers {[weak self] (value, error) -> (Void) in
            
            guard error == nil else {
                failure(error)
                return
            }
            
            guard let resultsDict = value as? [AnyHashable : Any],
                let resultsArray = resultsDict["results"] as? [[AnyHashable : Any]] else {
                    failure(nil)
                    return
            }
            
            let randomUsersArray = RandomUserModel.jsonArrayToRandomUserModelArray(jsonArray: resultsArray)
            RealmManager.sharedInstance.clearCachedRandomUsers()
            RealmManager.sharedInstance.storeArrayToRealm(array: randomUsersArray)
            self?.usersArray = RealmManager.sharedInstance.getCachedRandomUsers()
            success()
        }
    }
}

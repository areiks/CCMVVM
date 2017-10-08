//
//  RandomUsersFavouriteListViewModel.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 07.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//
import Foundation

class RandomUsersFavouriteListViewModel: RandomUsersListViewControllerDataSource  {
    var usersArray = [RandomUserModel]()
    
    init() {
        self.usersArray = RealmManager.sharedInstance.getFavouritedUsers()
    }
    
    // Settings
    func refreshIsEnabled() -> Bool {
        return false
    }
    
    func favouritesIsEnabled() -> Bool {
        return false
    }
    
    func rowSelectionEnabled() -> Bool {
        return false
    }
    
    func title() -> String {
        return "Favourited users"
    }
    
    // TableView
    func numberOfRows() -> Int {
        return self.usersArray.count
    }
    
    func deleteRandomUser(index: Int) {
        guard index < usersArray.count else {
            return
        }
        
        RealmManager.sharedInstance.unfavouriteUser(randomUser: self.usersArray[index])
        self.usersArray.remove(at: index)
    }
    
    func randomUserModelForIndex(index: Int) -> RandomUserModel {
        return self.usersArray[index]
    }
    
    // actions
    
    func search(phrase: String) {
        self.usersArray = RealmManager.sharedInstance.getFilteredFavouritedUsers(searchPhrase: phrase)
    }
    
    func refreshData() {
        self.usersArray = RealmManager.sharedInstance.getFavouritedUsers()
    }
    
    // empty implementations
    func selectedRandomUser(index: Int) {
       //handled by deletion, one action is enough here
    }
    
    func downloadNewUsers(success: @escaping () -> Void, failure: @escaping (NSError?) -> Void) {
        
    }
}

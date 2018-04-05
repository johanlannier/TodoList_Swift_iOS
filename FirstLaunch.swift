//
//  FirstLaunch.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class FirstLaunch {
    
    static let sharedInstance = FirstLaunch()
    
    enum UserDefaultsKey: String {
        case firstLaunch = "firstLaunch"
        case ItemID = "ItemID"
    }
    
    var firstLaunch: Bool {
        get{
            if UserDefaults.standard.object(forKey: UserDefaultsKey.firstLaunch.rawValue) == nil {
                return true
            } else {
                return UserDefaults.standard.bool(forKey: UserDefaultsKey.firstLaunch.rawValue)
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.firstLaunch.rawValue)
        }
    }
    
    func nextCheckListItemID() -> Int{
        var itemID = UserDefaults.standard.integer(forKey: UserDefaultsKey.ItemID.rawValue)
        itemID = itemID + 1
        UserDefaults.standard.set(itemID, forKey: UserDefaultsKey.ItemID.rawValue)
        return itemID
    }

}

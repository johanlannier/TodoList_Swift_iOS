//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation
import UIKit

class Checklist: Codable {
    
    var name: String
    var items: Array<CheckListItem>
    var icon: IconAsset
    
    init(nom: String, list: Array<CheckListItem> = [], icon: IconAsset = .NoIcon) {
        self.name = nom
        self.items = list
        self.icon=icon
    }
    
    var uncheckedItemsCount: Int {
        return items.filter{ !$0.checked }.count
    }
}

enum IconAsset : String, Codable {
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}

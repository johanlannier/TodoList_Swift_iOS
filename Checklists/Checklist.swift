//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class Checklist: Codable {
    
    var name: String
    var items: Array<CheckListItem>
    
    init(nom: String, list: Array<CheckListItem> = []) {
        self.name = nom
        self.items = list
    }
    
    var uncheckedItemsCount: Int {
        return items.filter{ !$0.checked }.count
    }
}

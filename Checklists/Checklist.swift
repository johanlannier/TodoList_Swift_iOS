//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class Checklist {
    
    var nom: String
    var items: Array<CheckListItem>
    
    init(nom: String, list: Array<CheckListItem> = []) {
        self.nom = nom
        self.items = list
    }
}

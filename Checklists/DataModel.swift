//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class DataModel {
    var ListCheckList : Array<Checklist> = []
    static let sharedInstance = DataModel()
    var documentDirectory : URL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
    var dataFileURL : URL = URL(fileURLWithPath: "")
    
    
        init () {
            let file = "data.json"
            dataFileURL = documentDirectory.appendingPathComponent(file)
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(saveCheckList),
                name: .UIApplicationDidEnterBackground,
                object: nil)
        }
    
        @objc func saveCheckList(){
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            do {
            let data = try encoder.encode(ListCheckList)
            try data.write(to: dataFileURL)
         } catch {
                }
        }
    
        func loadCheckList(){
            let decoder = JSONDecoder()
            do {
                let data = try String(contentsOf: dataFileURL, encoding: .utf8).data(using: .utf8)
                ListCheckList = try decoder.decode([Checklist].self, from: data!)
            } catch {
            }
            if FirstLaunch.sharedInstance.firstLaunch {
                ListCheckList.append(Checklist(nom: "Edit your first item, Swipe me for delete"))
                FirstLaunch.sharedInstance.firstLaunch = false
                saveCheckList()
            }
        }
    
    public func sortCheckList(){
        ListCheckList = ListCheckList.sorted{ $0.name.localizedStandardCompare($1.name) == .orderedAscending }
    }
}

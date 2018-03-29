//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var checklistList: Array<Checklist> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checklistList.append(Checklist(nom: "liste 1"))
        checklistList.append(Checklist(nom: "liste 2"))
        checklistList.append(Checklist(nom: "liste 3"))
        checklistList.append(Checklist(nom: "liste 4"))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        cell.textLabel?.text = checklistList[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            if let destVC = segue.destination as? CheckListViewController  {
                let cell = sender as! UITableViewCell
                destVC.list = checklistList[(tableView.indexPath(for: cell)?.row)!]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistList.count
    }


}

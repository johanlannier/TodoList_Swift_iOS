//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    @IBOutlet var viewTable: UITableView!
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checklistList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            if let destVC = segue.destination as? CheckListViewController  {
                let cell = sender as! UITableViewCell
                destVC.list = checklistList[(tableView.indexPath(for: cell)?.row)!]
            }
        }
        else if segue.identifier == "addList"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? AddListViewController  {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editList"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? AddListViewController  {
                let cell = sender as! UITableViewCell
                destVC.ListToEdit = checklistList[(viewTable.indexPath(for: cell)?.row)!]
                destVC.delegate = self
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


extension AllListViewController: AddListViewControllerDelegate{
    func AddListViewControllerDidCancel(_ controller: AddListViewController) {
        dismiss(animated: true)
    }
    
    func AddListViewController(_ controller: AddListViewController, didFinishAddingItem item: Checklist) {
        checklistList.append(item)
        viewTable.insertRows(at: [IndexPath(row: checklistList.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        dismiss(animated: true)
    }
    
    func AddListViewController(_ controller: AddListViewController, didFinishEditingItem item: Checklist) {
        controller.dismiss(animated: true)
        let index = IndexPath(item: checklistList.index(where: {$0 === item})!, section: 0)
        tableView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
    }
}

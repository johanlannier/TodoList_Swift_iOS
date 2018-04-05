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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
            DataModel.sharedInstance.loadCheckList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewTable.reloadData()
    }
    
    func configureDetailTitle(_ cell: UITableViewCell, _ item: Checklist){
        if(item.items.count == 0){
            cell.detailTextLabel?.text = "(No Item)"
        } else if(item.uncheckedItemsCount == 0){
            cell.detailTextLabel?.text = "All Done !"
        } else {
            cell.detailTextLabel?.text = String(item.uncheckedItemsCount)+" items not completed"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        /*checklistList.append(Checklist(nom: "liste 1"))
        checklistList.append(Checklist(nom: "liste 2"))
        checklistList.append(Checklist(nom: "liste 3"))
        checklistList.append(Checklist(nom: "liste 4"))
        
        for list in checklistList {
            list.items.append(CheckListItem(text : "Item for " + list.name))
        }*/
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        cell.textLabel?.text = DataModel.sharedInstance.ListCheckList[indexPath.row].name
        self.configureDetailTitle(cell, DataModel.sharedInstance.ListCheckList[indexPath.row])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.sharedInstance.ListCheckList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
            DataModel.sharedInstance.saveCheckList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            if let destVC = segue.destination as? CheckListViewController  {
                let cell = sender as! UITableViewCell
                destVC.list = DataModel.sharedInstance.ListCheckList[(tableView.indexPath(for: cell)?.row)!]
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
                destVC.ListToEdit = DataModel.sharedInstance.ListCheckList[(tableView.indexPath(for: cell)?.row)!]
                destVC.delegate = self
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.sharedInstance.ListCheckList.count
    }


}


extension AllListViewController: AddListViewControllerDelegate{
    func AddListViewControllerDidCancel(_ controller: AddListViewController) {
        dismiss(animated: true)
    }
    
    func AddListViewController(_ controller: AddListViewController, didFinishAddingItem item: Checklist) {
        DataModel.sharedInstance.ListCheckList.append(item)
        let index = IndexPath(item : DataModel.sharedInstance.ListCheckList.count-1, section : 0)
        DataModel.sharedInstance.saveCheckList()
        tableView.insertRows(at: [index] , with: UITableViewRowAnimation.none)
        dismiss(animated: true)
    }
    
    func AddListViewController(_ controller: AddListViewController, didFinishEditingItem item: Checklist) {
        controller.dismiss(animated: true)
        let index = IndexPath(item : DataModel.sharedInstance.ListCheckList.index(where:{ $0 === item })!, section : 0)
        tableView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
        DataModel.sharedInstance.saveCheckList()
    }
}

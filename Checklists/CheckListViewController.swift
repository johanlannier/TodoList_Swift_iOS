//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var items: Array<CheckListItem> = []
    
    @IBOutlet var viewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items.append(CheckListItem(text: "Item1", checked: true))
        items.append(CheckListItem(text: "Item2"))
        viewTable.delegate=self
        viewTable.dataSource=self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? AddItemViewController  {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editItem"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? AddItemViewController  {
                let cell = sender as! ChecklistItemCell
                destVC.itemToEdit = items[(viewTable.indexPath(for: cell)?.row)!]
                destVC.delegate = self
            }
        }
    }
    
    func configureCheckmark(for cell: ChecklistItemCell, withItem item: CheckListItem){
        if item.checked {
            cell.itemChecked.isHidden=false
        } else {
            cell.itemChecked.isHidden=true
        }
    }
    func configureText(for cell: ChecklistItemCell, withItem item: CheckListItem){
        cell.itemText.text=item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDummyTodo(_ sender: UIBarButtonItem) {
        items.append(CheckListItem(text: "ItemAdd", checked: false))
        viewTable.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        viewTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ChecklistItemCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        //cell.textLabel?.text="COUCOU NICOLETTA"
        configureText(for: cell, withItem: items[indexPath.row])
        configureCheckmark(for: cell, withItem: items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].toggleChecked()
        viewTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }

}

extension CheckListViewController: AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        items.append(item)
        viewTable.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        dismiss(animated: true)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem){
        controller.dismiss(animated: true)
        let index = IndexPath(item: items.index(where: {$0 === item})!, section: 0)
        tableView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
    }
}

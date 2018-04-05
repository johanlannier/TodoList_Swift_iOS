//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var list: Checklist!
    //var documentDirectory: URL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
    //var dataFileUrl: URL = URL(fileURLWithPath: "")
    //let fileName="Checklists.json"
    
    
    @IBOutlet var viewTable: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //dataFileUrl=documentDirectory.appendingPathComponent(fileName)
        //loadChecklistItems()
    }
    
    /*func saveChecklistItems(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let data = try encoder.encode(list.items)
            try data.write(to: dataFileUrl)
        } catch{
            
        }
    }
    
    func loadChecklistItems(){
        let decoder=JSONDecoder()
        do{
        let data = try String(contentsOf: dataFileUrl, encoding: String.Encoding.utf8).data(using: String.Encoding.utf8)
            list.items = try decoder.decode([CheckListItem].self, from: data!)
        }catch {
            
        }
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title=list.name
        //items.append(CheckListItem(text: "Item1", checked: true))
        //items.append(CheckListItem(text: "Item2"))
        viewTable.delegate=self
        viewTable.dataSource=self
        //print(dataFileUrl.absoluteURL)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? ItemDetailViewController  {
                destVC.delegate = self
            }
        }
        else if segue.identifier == "editItem"{
            if let navVC = segue.destination as? UINavigationController,
                let destVC = navVC.topViewController as? ItemDetailViewController  {
                let cell = sender as! ChecklistItemCell
                destVC.itemToEdit = list.items[(viewTable.indexPath(for: cell)?.row)!]
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
        //saveChecklistItems()
    }
    func configureText(for cell: ChecklistItemCell, withItem item: CheckListItem){
        cell.itemText.text=item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDummyTodo(_ sender: UIBarButtonItem) {
        list.items.append(CheckListItem(text: "ItemAdd", checked: false))
        viewTable.insertRows(at: [IndexPath(row: list.items.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ChecklistItemCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        //cell.textLabel?.text="COUCOU NICOLETTA"
        configureText(for: cell, withItem: list.items[indexPath.row])
        configureCheckmark(for: cell, withItem: list.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list.items[indexPath.row].toggleChecked()
        viewTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }

}

extension CheckListViewController: ItemDetailViewControllerDelegate{
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        list.items.append(item)
        viewTable.insertRows(at: [IndexPath(row: list.items.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        dismiss(animated: true)
        //saveChecklistItems()
    }
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem){
        controller.dismiss(animated: true)
        let index = IndexPath(item: list.items.index(where: {$0 === item})!, section: 0)
        tableView.reloadRows(at: [index], with: UITableViewRowAnimation.fade)
        //saveChecklistItems()
    }
}

//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate  {

    
    @IBOutlet weak var newItem: UITextField!
    
    var itemToEdit: CheckListItem!
    
    var delegate: ItemDetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let edit=itemToEdit{
            newItem.text=edit.text
            self.navigationItem.title="Edit Item"
        }
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        newItem.becomeFirstResponder()
        newItem.delegate = self
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @IBAction func done(_ sender: Any) {
        if let item = newItem.text {
            if (itemToEdit) != nil {
                itemToEdit.text = item
                delegate.itemDetailViewController(self, didFinishEditingItem: itemToEdit)
            }else {
                delegate.itemDetailViewController(self, didFinishAddingItem: CheckListItem(text: item))
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate.itemDetailViewControllerDidCancel(self)
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
            if newString.isEmpty {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            return true
        }
        return false
    }
    
    }

protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem)
}
    


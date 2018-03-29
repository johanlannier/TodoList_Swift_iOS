//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate  {

    
    @IBOutlet weak var newItem: UITextField!
    
    var itemToEdit: CheckListItem!
    
    var delegate: AddItemViewControllerDelegate!
    
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
            if let edit = itemToEdit {
                itemToEdit.text = item
                delegate.addItemViewController(self, didFinishEditingItem: itemToEdit)
            }else {
                delegate.addItemViewController(self, didFinishAddingItem: CheckListItem(text: item))
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate.addItemViewControllerDidCancel(self)
        
        
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

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem)
}
    


//
//  AddListViewController.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AddListViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var TextField: UITextField!
    
    var delegate: AddListViewControllerDelegate!
    
    var ListToEdit: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.delegate=self
        navigationItem.rightBarButtonItem?.isEnabled = false
        if let edit=ListToEdit{
            TextField.text=edit.name
            self.navigationItem.title="Edit List"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = TextField.text {
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
    
    override func viewWillAppear(_ animated: Bool) {
        TextField.becomeFirstResponder()
    }

    @IBAction func done() {
        if (ListToEdit) != nil {
            ListToEdit.name = TextField.text!
            delegate.AddListViewController(self, didFinishEditingItem: ListToEdit)
        }else {
            delegate.AddListViewController(self, didFinishAddingItem: Checklist(nom: TextField.text!))
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
}


protocol AddListViewControllerDelegate : class {
    func AddListViewControllerDidCancel(_ controller: AddListViewController)
    
    func AddListViewController(_ controller: AddListViewController, didFinishAddingItem item: Checklist)
    func AddListViewController(_ controller: AddListViewController, didFinishEditingItem item: Checklist)
}

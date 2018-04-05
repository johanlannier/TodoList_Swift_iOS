//
//  AddListViewController.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: ListDetailViewControllerDelegate!
    
    var ListToEdit: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.delegate=self
        navigationItem.rightBarButtonItem?.isEnabled = false
        if let edit=ListToEdit{
            TextField.text=edit.name
            self.navigationItem.title="Edit List"
            imageView.image = edit.icon.image
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
            delegate.ListDetailViewController(self, didFinishEditingItem: ListToEdit)
        }else {
            delegate.ListDetailViewController(self, didFinishAddingItem: Checklist(nom: TextField.text!))
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
}


protocol ListDetailViewControllerDelegate : class {
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: Checklist)
}

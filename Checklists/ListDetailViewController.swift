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
    
    var icon: IconAsset = IconAsset.Folder
    
    var delegate: ListDetailViewControllerDelegate!
    
    var ListToEdit: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.delegate=self
        navigationItem.rightBarButtonItem?.isEnabled = false
        imageView.image = icon.image
        
        if let edit=ListToEdit{
            TextField.text=edit.name
            self.navigationItem.title="Edit List"
            imageView.image = edit.icon.image
            self.icon = edit.icon
        }
    }
    
    func iconChange(newIcon: IconAsset){
        if let edit = ListToEdit, edit.icon != newIcon {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        self.icon = newIcon
        self.imageView.image = self.icon.image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = TextField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
            if newString.isEmpty {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else if let edit = ListToEdit, newString == edit.name {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editIcon"{
            if let dest = segue.destination as? IconPickerViewController {
                dest.delegate = self
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TextField.delegate = self
        TextField.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let edit = ListToEdit, edit.icon != self.icon {
          self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
    }

    @IBAction func done() {
        if let item = TextField.text {
            if let edit = ListToEdit {
                ListToEdit.name = item
                ListToEdit.icon = self.icon
                delegate.ListDetailViewController(self, didFinishEditingItem: ListToEdit)
            }else {
                delegate.ListDetailViewController(self, didFinishAddingItem: Checklist(nom: item, icon: self.icon))
            }
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

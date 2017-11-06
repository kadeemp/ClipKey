//
//  NewKeyViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/28/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit
import CoreData

class KeyViewController: UIViewController {

    //MARK:- Variable Declaration

    var keyLabel:String = ""
    var keyContent:String = ""
    var indexOfKey:Int? = nil
    var key = NSManagedObject()

    //MARK:- View Intitialization

    override func viewDidLoad() {
        super.viewDidLoad()
        labelTextField.becomeFirstResponder()
        labelTextField.attributedPlaceholder = NSAttributedString(string: "Key Label", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5 )])
        contentTextField.attributedPlaceholder = NSAttributedString(string: "Key Content", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5 )])
        self.navigationController?.navigationItem.leftBarButtonItem?.title = "Back"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backToInitial))

    }

    override func viewWillAppear(_ animated: Bool) {
        
        if indexOfKey != nil {
            key = KeyManager.sharedInstance.keyAt(index: indexOfKey!)
            keyLabel  = KeyManager.sharedInstance.keyLabelAt(index: indexOfKey!)
            keyContent = KeyManager.sharedInstance.keyContentAt(index: indexOfKey!)
            labelTextField.text = keyLabel
            contentTextField.text = keyContent
        }
    }
    @objc func backToInitial(sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    //MARK:- IB Outlets

    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!

    //MARK:- IB Actions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        if labelTextField.hasText && contentTextField.hasText {
            if indexOfKey == nil {
                KeyManager.sharedInstance.addKey(label: (labelTextField.text?.capitalized)!, content: contentTextField.text)
            } else {
                key.setValue(labelTextField.text, forKey: "label")
                key.setValue(contentTextField.text, forKey: "content")
                KeyManager.sharedInstance.save()
            }
        }
        if labelTextField.hasText && !(contentTextField.hasText) {
            contentTextField.text = labelTextField.text
            if indexOfKey == nil {
                KeyManager.sharedInstance.addKey(label: (labelTextField.text?.capitalized)!, content: contentTextField.text)
            } else {
                key.setValue(labelTextField.text, forKey: "label")
                key.setValue(contentTextField.text, forKey: "content")
                KeyManager.sharedInstance.save()
            }

        }

        navigationController?.popToRootViewController(animated: true)
    }


}

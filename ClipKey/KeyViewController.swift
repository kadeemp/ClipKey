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

    var keyLabel:String = ""
    var keyContent:String = ""
    var indexOfKey:Int? = nil
    var key = NSManagedObject()
    override func viewDidLoad() {
        super.viewDidLoad()
//        if key != nil {
//            print(key)
//        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {

     

        //Does not account for if there is only 1 Key
        if indexOfKey != nil {
            key = KeyManager.sharedInstance.keyAt(index: indexOfKey!)
            print(key)
            keyLabel  = KeyManager.sharedInstance.keyLabelAt(index: indexOfKey!)
            keyContent = KeyManager.sharedInstance.keyContentAt(index: indexOfKey!)
            labelTextField.text = keyLabel
            contentTextField.text = keyContent
        }
    }
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!

    @IBAction func saveButtonPressed(_ sender: Any) {
        if indexOfKey == nil {
        KeyManager.sharedInstance.addKey(label: labelTextField.text!, content: contentTextField.text!)
        } else {
            print("~~~~~~~~~~~")
            key.setValue(labelTextField.text, forKey: "label")
            key.setValue(contentTextField.text, forKey: "content")
            KeyManager.sharedInstance.save()
            
            print(key)
        }

       // HomeViewController.sharedInstance.reloadTable()
        navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

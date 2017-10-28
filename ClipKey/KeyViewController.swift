//
//  NewKeyViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/28/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class KeyViewController: UIViewController {
   // var key:NSManagedObject = nil

    var keyLabel:String = ""
    var keyContent:String = ""
    var indexOfKey:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        if key != nil {
//            print(key)
//        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print(indexOfKey)

        //Does not account for if there is only 1 Key
        if indexOfKey != 0 {
            keyLabel  = KeyManager.sharedInstance.keyAt(index: indexOfKey)
            keyContent = KeyManager.sharedInstance.keyContentAt(index: indexOfKey)
            labelTextField.text = keyLabel
            contentTextField.text = keyContent
        }
    }
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!

    @IBAction func saveButtonPressed(_ sender: Any) {
        KeyManager.sharedInstance.addKey(label: labelTextField.text!, content: contentTextField.text!)
        
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

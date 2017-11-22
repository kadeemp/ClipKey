//
//  NewKeyViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/28/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit
import CoreData

class KeyViewController: UIViewController, UITextFieldDelegate {

    //MARK:- Variable Declaration

    var keyLabel:String = ""
    var keyContent:String = ""
    var indexOfKey:Int? = nil
    var key: NSManagedObject?
    var isEditIndex:Int?
    var keyBoardIsVisible = false 

    //MARK:- View Intitialization

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTextField.delegate = self
        //no limit on bottom text field. 
//        self.contentTextField.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .done,
            target: self,
            action: #selector(backToInitial)
        )
        NotificationCenter.default.addObserver(self, selector: #selector(KeyViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyViewController.keyboardWillHide(notification: )),name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {

        if indexOfKey != nil {
            key = KeyManager.sharedInstance.keyAt(index: indexOfKey!)
            keyLabel  = KeyManager.sharedInstance.keyLabelAt(index: indexOfKey!)
            keyContent = KeyManager.sharedInstance.keyContentAt(index: indexOfKey!)
            labelTextField.text = keyLabel
            contentTextField.text = keyContent
        }
        if isEditIndex != nil {
            titleLabel.text = "Edit Key"
        }
    }
    @objc func backToInitial(sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK:- IB Outlets

    @IBOutlet var viewTouchGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: CustomButton!
    @IBOutlet weak var saveButton: CustomButton!

    @IBOutlet weak var stackViewTop_TitleBottom: NSLayoutConstraint!
    //MARK:- IB Actions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        if (labelTextField.isFirstResponder){
            labelTextField.resignFirstResponder()
            return
        }
        else if ( contentTextField.isFirstResponder ) {
            contentTextField.resignFirstResponder()
            return 
        }
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        submitKey()
    }
    @IBAction func screenTouched(_ sender: Any) {
//        if (labelTextField.isFirstResponder){
//            labelTextField.resignFirstResponder()
//
//        }
//        else if ( contentTextField.isFirstResponder ) {
//           contentTextField.resignFirstResponder()
//
//        }

    print("touched")
        
    }
    //MARK:- Textfield Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkMaxLength(textField: labelTextField, maxLength: 15)
        checkMaxLength(textField: contentTextField, maxLength: 279)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (labelTextField.isFirstResponder){
            contentTextField.becomeFirstResponder()

        }
        else if ( contentTextField.isFirstResponder ) {
            submitKey()
            
        }
        return true 
    }
//MARK:- Helper Functions

    func submitKey() {
        let labelText = labelTextField.text
        let contentText = contentTextField.text

        if labelTextField.hasText && contentTextField.hasText {
            if indexOfKey == nil {
                KeyManager.sharedInstance.addKey(label: (labelTextField.text?.capitalized)!,
                                                 content: contentTextField.text)
            } else {
                key!.setValue(labelTextField.text, forKey: "label")
                key!.setValue(contentTextField.text, forKey: "content")
                KeyManager.sharedInstance.save()
            }
        }
        if labelTextField.hasText && !(contentTextField.hasText) {
            contentTextField.text = labelTextField.text
            if indexOfKey == nil {
                KeyManager.sharedInstance.addKey(label: (labelTextField.text?.capitalized)!,
                                                 content: contentTextField.text)
            } else {
                key!.setValue(labelTextField.text, forKey: "label")
                key!.setValue(contentTextField.text, forKey: "content")
                KeyManager.sharedInstance.save()
            }
        }
        navigationController?.popToRootViewController(animated: true)

    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.characters.count > maxLength) {
            textField.deleteBackward()
        }
    }
    func animateUp() {
        // moves views up to avoid keyboard
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.stackViewTop_TitleBottom.constant -= 25
                        //print("~~~~~~~~~")
                        self.view.layoutIfNeeded()
                        //         self.didAnimate()
                 //       print(self.isAnimated)
        }, completion: { (finished: Bool) in
     //       self.isAnimated = true
        })
    }

    func animateDown() {
        // moves views down after keyboard leaves
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.stackViewTop_TitleBottom.constant += 25
                        self.view.layoutIfNeeded()
                        //      self.isAnimated = false
        }, completion: nil)
    }

    @objc func keyboardWillShow (notification: NSNotification) {
        if (keyBoardIsVisible) {
            return
        } else {
            self.animateUp()
            self.keyBoardIsVisible = true
        }
       // print("initial animate result:" + String((isAnimated)))

    }

    @objc func keyboardWillHide (notification: NSNotification) {
        if(keyBoardIsVisible) {
            animateDown()
            self.keyBoardIsVisible = false
        }
    }
}

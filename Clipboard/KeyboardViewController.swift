//
//  KeyboardViewController.swift
//  Clipboard
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    @IBOutlet weak var clipboard: UITableView!


    override func viewWillAppear(_ animated: Bool) {
        let allKeys = KeyManager.sharedInstance.loadData()
        for i in 0..<allKeys.count {
            var key = allKeys[i]
            titles.append(key.value(forKey: "label") as! String)
            keys.append(key.value(forKey: "content") as! String)
        }

    }

    var titles:[String] = []
    var keys:[String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clipboard.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = keys[indexPath.row]
        let proxy = textDocumentProxy
        proxy.insertText(text)
    }

    
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        //self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}

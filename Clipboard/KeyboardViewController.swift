//
//  KeyboardViewController.swift
//  Clipboard
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- Variable Declaration

    var titles = ["String"]
    var keys = [""]
    let userDefaults = UserDefaults(suiteName: "group.AllFiles")

    //MARK:- IB Outlets

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var clipboard: UITableView!

    //MARK:- View Intitialization

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        titles = userDefaults?.array(forKey: "titles") as! [String]
        print(titles)
        keys = (userDefaults?.stringArray(forKey: "keys"))!
        clipboard.reloadData()
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()

        // Add custom view sizing constraints here
    }
    
    //MARK:- IB Actions

    @IBAction func refreshButtonPressed(_ sender: Any) {
        clipboard.reloadData()
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        let proxy = textDocumentProxy
        proxy.deleteBackward()
    }
    @IBAction func nextKeyboardButtonPressed(_ sender: Any) {
        advanceToNextInputMode()
    }

    //MARK:- TableView Management

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clipboard.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = keys[indexPath.row] + " "
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

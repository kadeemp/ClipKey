//
//  KeyboardViewController.swift
//  Clipboard
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDataSource, UICollectionViewDelegate {



    //MARK:- Variable Declaration
    

    var titles = ["String"]
    var keys = [""]
    let constants = Constants()

    //MARK:- IB Outlets

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var clipboard: UITableView!
    @IBOutlet weak var clipboardCollection: UICollectionView!

    //MARK:- View Intitialization



    override func viewWillAppear(_ animated: Bool) {

        if let unwrappedTitles = constants.userDefaults?.array(forKey: constants.titlesKey) as? [String] {
            print(unwrappedTitles)
            titles = unwrappedTitles

        } else {
            titles = []
            clipboardCollection.reloadData()
        }
        if let unwrappedKeys = (constants.userDefaults?.stringArray(forKey: constants.keysKey)) {
            keys = unwrappedKeys
        }
        else {
            
        }
        if let layout = clipboardCollection.collectionViewLayout as? ClipboardCollectionViewLayout {
            layout.delegate = self
        }

        if let flowLayout = clipboardCollection.collectionViewLayout as? UICollectionViewFlowLayout { flowLayout.estimatedItemSize = CGSize(width:1, height:1) }
        clipboardCollection.reloadData()
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()

    }
    
    //MARK:- IB Actions

    @IBAction func refreshButtonPressed(_ sender: Any) {
        clipboard.reloadData()
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        let proxy = textDocumentProxy
        if let selectedTextcount = proxy.documentContextBeforeInput?.characters.count {

            for _ in 0..<selectedTextcount {
                proxy.deleteBackward()
            }
        }
    }
    @IBAction func spaceButtonPressed(_ sender: Any) {
        let text = " "
        let proxy = textDocumentProxy
        proxy.insertText(text)
    }
    @IBAction func nextKeyboardButtonPressed(_ sender: Any) {
        advanceToNextInputMode()
    }
    //MARK:- CollectionView Management

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clipboardCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClipboardCollectionViewCell
        cell.label.text = titles[indexPath.row]
        cell.label.preferredMaxLayoutWidth = 500
        cell.contentView.clipsToBounds = true 
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = keys[indexPath.row]
        let proxy = textDocumentProxy
        proxy.insertText(text)
        
    }


    override func textWillChange(_ textInput: UITextInput?) {

    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }

    }

}
extension KeyboardViewController: ClipboardCollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, sizeForTitleAt indexPath: IndexPath) -> CGSize {
        let sizingLabel = UILabel()
        sizingLabel.font = UIFont.systemFont(ofSize: 17)
        sizingLabel.text = titles[indexPath.row]
        return sizingLabel.intrinsicContentSize
    }






}

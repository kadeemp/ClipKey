//
//  ViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let constants = Constants()

    //MARK:- Variable Declaration

    var titles:[String] = []
    var keys:[String] = []

    //MARK:- IB Outlets

    @IBOutlet weak var newKeyButtonPressed: UIButton!
    @IBOutlet weak var keysTable: UITableView!

    //MARK:- IB Actions

    @IBAction func newKeyButtonPressed(_ sender: Any) {
        if let newKeyView = storyboard?.instantiateViewController(withIdentifier: constants.keyVCIdentifier) {
            navigationController?.pushViewController(newKeyView, animated: true)
        }
    }

    //MARK:- View Intitialization

    override func viewWillAppear(_ animated: Bool) {
        navBarSetup()
        loadKeys()
    }

    //MARK:- TableView Management

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = keysTable.dequeueReusableCell(withIdentifier:constants.defaultCellIdentifier)
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            titles.remove(at: indexPath.row)
            keysTable.deleteRows(at: [indexPath] , with: .fade)
            KeyManager.sharedInstance.remove(index: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:constants.viewKeySegueIdentifier, sender: self)
    }



    //MARK:- Class Functions

    func navBarSetup() {
        self.title = constants.title
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 92/255.0, green: 107/255.0, blue: 140/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }

    func loadKeys() {

        let allKeys = KeyManager.sharedInstance.loadData()
        if (titles == [] && keys == []) {
            for i in 0..<allKeys.count {
                var key = allKeys[i]
                titles.append(key.value(forKey: constants.label) as! String)
                keys.append(key.value(forKey: constants.content) as! String)
            }
            KeyManager.sharedInstance.setKeys(keys: keys)
            KeyManager.sharedInstance.setTitles(titles: titles)
        }
    }

    //MARK:- Navigation preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == constants.viewKeySegueIdentifier {
            if let indexPath = keysTable.indexPathForSelectedRow {
                let destVC = segue.destination as! KeyViewController
                destVC.indexOfKey = indexPath.row
                destVC.isEditIndex = 1
            }
        }
    }

}


//
//  ViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let userDefaults = UserDefaults(suiteName: "group.AllFiles")

    //MARK:- Variable Declaration

    var titles:[String] = []
    var keys:[String] = []

    //MARK:- IB Outlets

    @IBOutlet weak var newKeyButtonPressed: UIButton!
    @IBOutlet weak var keysTable: UITableView!

    //MARK:- IB Actions

    @IBAction func newKeyButtonPressed(_ sender: Any) {
        if let newKeyView = storyboard?.instantiateViewController(withIdentifier: "keyViewController") {
            navigationController?.pushViewController(newKeyView, animated: true)
        }
    }

    //MARK:- View Intitialization

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ClipKey"

        //  navigationItem.rightBarButtonItem = editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {

        let allKeys = KeyManager.sharedInstance.loadData()
        print(allKeys)
        print("~~~~~~~~~~~~~~~~~`")
        print("~~~~~~~~~~~~~~~~~`")
        titles = []
        keys = []
        for i in 0..<allKeys.count {
            var key = allKeys[i]
            titles.append(key.value(forKey: "label") as! String)
            keys.append(key.value(forKey: "content") as! String)
        }
        KeyManager.sharedInstance.setKeys(keys: keys)
        KeyManager.sharedInstance.setTitles(titles: titles)
    }

    //MARK:- TableView Management

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = keysTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(titles)

            titles.remove(at: indexPath.row)
            keysTable.deleteRows(at: [indexPath] , with: .fade)
            KeyManager.sharedInstance.remove(index: indexPath.row)
            print(titles)

            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewKey", sender: self)
    }

    //MARK:- Navigation preparation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let allKeys = KeyManager.sharedInstance.loadData()
        if segue.identifier == "viewKey" {
            if let indexPath = keysTable.indexPathForSelectedRow {
                let destVC = segue.destination as! KeyViewController
                destVC.indexOfKey = indexPath.row
                print(#function)
                print(indexPath.row)

 

            }
        }
    }

}


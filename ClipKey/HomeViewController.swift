//
//  ViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ClipKey"
        navigationItem.rightBarButtonItem = editButtonItem
    }

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

//    var titles = ["First", "Last", "Full Name", "Address", "City", "Zip Code"]
//    var keys = ["Kadeem", "Palacios", "Kadeem Palacios", "2443 Fitzpatrick st.", "San Pablo, Ca", "94806"]

    @IBAction func newKeyButtonPressed(_ sender: Any) {
        if let newKeyView = storyboard?.instantiateViewController(withIdentifier: "keyViewController") {
            navigationController?.pushViewController(newKeyView, animated: true)
        }
    }
    @IBOutlet weak var newKeyButtonPressed: UIButton!
    @IBOutlet weak var keysTable: UITableView!

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
            titles.remove(at: indexPath.row)
            KeyManager.sharedInstance.remove(index: indexPath.row)
            keysTable.deleteRows(at: [indexPath] , with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let newKeyView = storyboard?.instantiateViewController(withIdentifier: "keyViewController") {
//            navigationController?.pushViewController(newKeyView, animated: true)
        performSegue(withIdentifier: "viewKey", sender: self)
      //  }
    }

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

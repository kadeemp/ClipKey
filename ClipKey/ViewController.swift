//
//  ViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 10/27/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ClipKey"
        navigationItem.rightBarButtonItem = editButtonItem

        for i in 0..<titles.count{
            KeyManager.sharedInstance.addKey(label: titles[i], content: keys[i])
        }
        KeyManager.sharedInstance.loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
//var titles = []
//var keys = []

    var titles = ["First", "Last", "Full Name", "Address", "City", "Zip Code"]
    var keys = ["Kadeem", "Palacios", "Kadeem Palacios", "2443 Fitzpatrick st.", "San Pablo, Ca", "94806"]

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
            keysTable.deleteRows(at: [indexPath] , with: .fade)
        }
    }

}


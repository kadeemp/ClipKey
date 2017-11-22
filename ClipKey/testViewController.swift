//
//  testViewController.swift
//  ClipKey
//
//  Created by Kadeem Palacios on 11/19/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit

import SwiftGifOrigin
class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.imageView.image = UIImage.gif(name: "clipKeySettingsSetup")
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imageView: UIImageView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

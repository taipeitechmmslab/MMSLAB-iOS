//
//  ViewController.swift
//  lab6-1-2
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showCustomPopupView(_ sender: Any) {
        let popupVC = customPopupViewController()
        popupVC.showOn(VC: self)
    }
    
}

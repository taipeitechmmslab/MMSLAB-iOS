//
//  completeViewController.swift
//  lab4-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class completeViewController: UIViewController {
    var closure  : ((String)->())!
    var myDrink : drink!
    @IBOutlet var orderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderLabel.text = String(format:"您的飲料：%@\n甜度為：%@\n冰量為：%@\n售價：%d",myDrink.name, myDrink.sweetness, myDrink.ice, myDrink.price)
    }

    @IBAction func backToHomePage(_ sender: Any) {
        closure("您的點餐已送出\n請點選開始點餐進行下一次點餐作業")
        dismiss(animated: true, completion: nil)
    }
}

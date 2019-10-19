//
//  orderViewController.swift
//  lab4-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

@objc protocol OrderViewDelegate {
    func sendOrder(myOrder:drink)
}

class orderViewController: UIViewController {
    var myDrink : drink!
    weak var delegate : OrderViewDelegate?
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sweetSelect: UISegmentedControl!
    @IBOutlet var iceSelect: UISegmentedControl!
    @IBOutlet var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(myDrink != nil){
            nameTextField.text = myDrink.name
            sweetSelect.selectedSegmentIndex = myDrink.sweetSelectIndex
            iceSelect.selectedSegmentIndex = myDrink.iceSelectIndex
            priceTextField.text = "\(myDrink.price)"
        }
    }

    @IBAction func sendBtnClick(_ sender: Any) {
        if(myDrink == nil){
            myDrink = drink()
        }
        myDrink.name = nameTextField.text ?? ""
        myDrink.sweetSelectIndex = sweetSelect.selectedSegmentIndex
        myDrink.sweetness = sweetSelect.titleForSegment(at: sweetSelect.selectedSegmentIndex)!
        myDrink.iceSelectIndex = iceSelect.selectedSegmentIndex
        myDrink.ice = iceSelect.titleForSegment(at: iceSelect.selectedSegmentIndex)!
        myDrink.price = Int(priceTextField.text!) ?? 0
        delegate?.sendOrder(myOrder: myDrink)
        navigationController?.popViewController(animated: true)
    }
}

var int1:Int? = 0
var int2:Int! = 1
let sum = add(a:int1 ?? 2,b:int2)

func add(a:Int,b:Int) -> Int {
    return a+b
}

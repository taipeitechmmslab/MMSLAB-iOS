//
//  SecViewController.swift
//  lab4-1-6
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

//宣告合約內容
@objc protocol SecViewControllerDelegate {
    //必定要執行的副程式（義務）
    func changeTitle(title:String)
    //選擇性要執行的副程式（權利）
    @objc optional func selectionFunction()
}



class SecViewController: UIViewController {
    weak var delegate : SecViewControllerDelegate?
    
    var data = ""
    
    @IBOutlet var showDataLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showDataLabel.text = data
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //宣告一個欲回傳的字串為lastTitle
        let lastTitle = "新標題"
        //透過合約內的「changeTitle:」副程式將lastTitle傳回ViewController頁面
        delegate?.changeTitle(title: lastTitle)
    }
    
}


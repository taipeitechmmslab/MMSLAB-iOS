//
//  SecViewController.swift
//  lab4-1-6
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {
    //宣告closure為一個閉包，輸入為一個String，沒有輸出
    var closure : ((String)->())?
    var data = ""
    
    
    
    @IBOutlet var showDataLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showDataLabel.text = data
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //宣告lastTitle，用於讀取textField中的text參數
        let lastTitle = textField.text
        //將所讀取到的字串作為Closure的參數傳入
        closure!(lastTitle ?? "")
    }
    
}


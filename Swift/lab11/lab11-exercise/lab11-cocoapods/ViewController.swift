//
//  ViewController.swift
//  lab11-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
import Toast

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.makeToast("顯示Toast")
    }

    @IBAction func showToastBtnclick(_ sender: Any) {
        //宣告showStr為textField內所輸入的文字
        let showstr = textField.text
        //判斷讀取到的文字是否為空字串，若不為空字串則代表使用者有輸入文字
        if(showstr != ""){
            view.makeToast(showstr)
        }
        else{
            view.makeToast("請於上方text field 中輸入要顯示的文字")
        }
    }
}

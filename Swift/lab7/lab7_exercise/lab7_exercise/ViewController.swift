//
//  ViewController.swift
//  lab7_exercise
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var collectionViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //一開始將Collection View的功能隱藏
        collectionViewContainer.isHidden = true
        //初始化水果名稱陣列
        let fruitNameArr = ["apple", "avocado", "banana", "cherries", "coconut", "grapes", "lemon", "orange", "peach", "pineapple", "strawberry", "tomato"]
        let userDefault = UserDefaults.standard
        userDefault.set(fruitNameArr, forKey: "fruitName")
        //設置此頁面的標題
        title = "demo table view"
    }
    
    @IBAction func switchBtnClick(_ btn: UIBarButtonItem) {
        if(btn.tag == 0){
            btn.tag = 1
            title = "demo collection view"
        }
        else{
            btn.tag = 0
            title = "demo table view"
        }
        //點擊切換功能將原本隱藏的頁面改為顯示，原本顯示的頁面改為隱藏
        tableViewContainer.isHidden = !tableViewContainer.isHidden
        collectionViewContainer.isHidden = !collectionViewContainer.isHidden
    }
}


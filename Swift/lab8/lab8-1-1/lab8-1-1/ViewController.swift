//
//  ViewController.swift
//  lab8-1-1
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func queueAndAsunc(){
        let mainQueue = DispatchQueue.main
        let secQueue = DispatchQueue.global()
        secQueue.async {
            //任務程式，在背景執行緒執行
            mainQueue.async {
                //回到主執行緒執行
            }
        }
    }
    
    @IBAction func testBtnClick(_ sender: Any) {
        let secQueue = DispatchQueue.global()
        print("開始")
        secQueue.async {
            print("任務1")
            sleep(1)//執行時間為1秒
            print("任務1完成")
        }
        secQueue.async {
            print("任務2")
            sleep(2)//執行時間為2秒
            print("任務2完成")
        }
        usleep(10000) //執行時間為0.1秒
        print("主執行緒空閒")
    }
    
}


//
//  ViewController.swift
//  lab8-1-2
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func GroupQueue(){
        //宣告 group 為一個佇列組（DispatchGroup）
        let group = DispatchGroup()
        
        let secQueue = DispatchQueue.global()
        secQueue.async(group: group){
            //任務程式
        }
        
        let mainQueue = DispatchQueue.main
        group.notify(queue: mainQueue) {
            //提醒任務
        }
    }
    
    @IBAction func testGroupQueue(_ sender: Any) {
        //建立佇列
        let globalQueue = DispatchQueue.global()
        let mainQueue = DispatchQueue.main
        //建立一個佇列組
        let groupQueue = DispatchGroup()
        print("開始")
        globalQueue.async(group: groupQueue){
            //隨機睡 1~5 秒
            let sleepTime = Int.random(in: 1...5)
            print("任務一：睡",sleepTime,"秒");
            sleep(UInt32(sleepTime));
            print("任務一完成");
        }
        globalQueue.async(group: groupQueue){
            //隨機睡 1~5 秒
            let sleepTime = Int.random(in: 1...5)
            print("任務二：睡",sleepTime,"秒");
            sleep(UInt32(sleepTime));
            print("任務二完成");
        }
        groupQueue.notify(queue: mainQueue) {
            //回主執行緒刷新
            print("兩個任務都已完成");
        }
        print("主執行緒空閒");
    }
}




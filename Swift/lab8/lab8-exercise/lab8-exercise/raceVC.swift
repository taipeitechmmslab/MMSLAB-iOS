//
//  raceVC.swift
//  lab8-exercise
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class raceVC: UIViewController {
    @IBOutlet var rabbitProgress: UIProgressView!
    @IBOutlet var turtleProgress: UIProgressView!
    var rabbitDis = 0
    var turtleDis = 0
    var finishFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startBtnClick(_ sender: Any) {
        rabbitDis = 0
        turtleDis = 0
        finishFlag = false
        rabbitProgress.progress = 0
        turtleProgress.progress = 0
        let secQueue = DispatchQueue.global()
        secQueue.async {
            //兔子跑的任務，判斷是否有人抵達終點（100），若無則會繼續跑
            while(self.rabbitDis<100 && self.turtleDis<100){
                //呼叫「rabbitRun()」函式設置兔子每次的移動距離與休息時間
                self.rabbitRun()
                //呼叫「showProgress」函式顯示進度條的狀態
                self.showProgress()
            }
            //呼叫「showWinner」函式顯示勝負
            self.showWinner()
        }
        secQueue.async {
            //烏龜跑的任務，判斷是否有人抵達終點（100），若無則會繼續跑
            while(self.rabbitDis<100 && self.turtleDis<100){
                //呼叫「tortoiseRun()」函式設置烏龜每次的移動距離與休息時間
                self.turtletRun()
                //呼叫「showProgress」函式顯示進度條的狀態
                self.showProgress()
            }
            //呼叫「showWinner」函式顯示勝負
            self.showWinner()
        }
    }
    
    func rabbitRun(){
        //兔子走隨機(1~10) 休隨機(1~10)
        let move = Int.random(in: 1...10)
        rabbitDis+=move
        var sleepTime = Int.random(in: 1...10)
        //如果烏龜跑超過八成則變成只休息1倍時間
        if(turtleDis>80){
            sleepTime = 1
        }
        print("兔子走",move,"休息",sleepTime)
        usleep(useconds_t(sleepTime*50000)) //設定休息時間 單位為微秒
    }
    
    func turtletRun(){
        turtleDis+=2
        usleep(50000) //固定休息0.05秒
    }
    
    func showProgress(){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            self.rabbitProgress.progress = Float(self.rabbitDis)/100
            self.turtleProgress.progress = Float(self.turtleDis)/100
        }
    }
    
    func showWinner(){
        if(!finishFlag){
            finishFlag = true
            var winMsg = ""
            if(rabbitDis > turtleDis){
                winMsg = "兔子勝利"
            }
            else if(rabbitDis < turtleDis){
                winMsg = "烏龜勝利"
            }
            else{
                winMsg = "平手"
            }
            let mainQueue = DispatchQueue.main
            mainQueue.async {
                let msgView = UIAlertController(title: winMsg, message: "", preferredStyle: .alert)
                let determineAction = UIAlertAction(title: "確定", style: .default, handler: nil)
                msgView.addAction(determineAction)
                self.present(msgView, animated: true, completion: nil)
            }
        }
    }
}




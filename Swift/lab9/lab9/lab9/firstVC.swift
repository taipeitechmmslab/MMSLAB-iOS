//
//  firstVC.swift
//  lab9
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class firstVC: UIViewController {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var registerBtn: UIButton!
    @IBOutlet var strartTimeBtn: UIButton!
    var timer : Timer?
    var time = 0
    var publicNotification : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.setTitle("通知已關閉", for: .normal)
        registerBtn.setTitle("通知已開啟", for: .selected)
        strartTimeBtn.setTitle("已停止計時", for: .normal)
        strartTimeBtn.setTitle("已開啟計時", for: .selected)
    }
    
    @IBAction func registerPublicNotification(_ btn: UIButton) {
        //宣告name為通知名稱
        let name = NSNotification.Name(rawValue: "publicNotification")
        //使用btn.selected判斷是否開啟通知
        if(!btn.isSelected){
            publicNotification = NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main){ (notification) in
                self.getPublicMsg(notification)
            }
            btn.isSelected = true
        }
        else{
            NotificationCenter.default.removeObserver(publicNotification!)
            btn.isSelected = false
        }
    }
    
    func getPublicMsg(_ notification:Notification){
        //將所傳遞的物件（notification.object）使用 Dictionary 讀取出來
        let timeData = notification.object as! Dictionary<String,Int>
        showTime(timeData)
    }
    
    @IBAction func startCount(_ btn: UIButton) {
        if(!btn.isSelected){
            //將計數時間歸零
            time = 0
            //使用閉包設定timer的執行事件
            timer = Timer(timeInterval: 1, repeats: true){ (Timer) in
                self.count()
            }
            //將timer加入至迴圈（RunLoop）中重複執行
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.default)
            btn.isSelected = true
        }
        else{
            //使用timer內建的「invalidate」函式，停止計時
            timer?.invalidate()
            btn.isSelected = false
        }
    }
    
    func count(){
        //時間秒數加一
        time = time + 1
        var timeDic = [String:Int]()
        timeDic["hour"] = Int(time/3600)
        timeDic["min"] = Int(time/60)
        timeDic["sec"] = Int(time%60)
        let name = NSNotification.Name("publicNotification")
        NotificationCenter.default.post(name:name, object:timeDic)
    }
    
    func showTime(_ timeData:Dictionary<String,Int>){
        let hour = timeData["hour"]!
        let min = timeData["min"]!
        let sec = timeData["sec"]!
        timeLabel.text = String(format:"%02d:%02d:%02d",hour,min,sec)
    }
}




//
//  secondVC.swift
//  lab9
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class secondVC: UIViewController{
    @IBOutlet var msgTextField: UITextField!
    @IBOutlet var sender: UILabel!
    @IBOutlet var msg: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var keyBoardBtn: UIButton!
    var publicNotification : NSObjectProtocol?
    var regionNotification : NSObjectProtocol?
    var keyboardShowNotification : NSObjectProtocol?
    var keyboardHideNotification : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNotification()
        keyBoardBtn.setTitle("已關閉系統鍵盤通知", for: .normal)
        keyBoardBtn.setTitle("已開啟系統鍵盤通知", for: .selected)
    }
    
    func initNotification(){
        let publicName = NSNotification.Name("publicNotification")
        publicNotification = NotificationCenter.default.addObserver(forName: publicName, object: nil, queue: OperationQueue.main){ (notification) in
            let timeData = notification.object as! Dictionary<String,Int>
            self.showTime(timeData)
        }
        let regionName = NSNotification.Name("regionNotification")
        regionNotification = NotificationCenter.default.addObserver(forName: regionName, object: nil, queue: OperationQueue.main){ (notification) in
            let msgData = notification.object as! Dictionary<String,String>
            self.showMsg(msgData)
        }
    }
    
    func showTime(_ timeData:Dictionary<String,Int>){
        let hour = timeData["hour"]!
        let min = timeData["min"]!
        let sec = timeData["sec"]!
        timeLabel.text = String(format:"%02d:%02d:%02d",hour,min,sec)
    }
    
    func showMsg(_ msgData:Dictionary<String,String>){
        sender.text = msgData["sender"]
        msg.text = msgData["msg"]
    }
    
    @IBAction func registerKeyBoardNotification(_ sender: UIButton) {
        if(!sender.isSelected){
            //註冊鍵盤相關通知
            keyboardShowNotification = NotificationCenter.default.addObserver(forName: UIResponder .keyboardWillShowNotification, object: nil, queue: OperationQueue.main){_ in
                print("觸發顯示鍵盤")
                self.sender.text = "系統";
                self.msg.text = "顯示鍵盤";
            }
            keyboardHideNotification = NotificationCenter.default.addObserver(forName: UIResponder .keyboardWillHideNotification, object: nil, queue: OperationQueue.main){_ in
                print("觸發隱藏鍵盤")
                self.sender.text = "系統";
                self.msg.text = "隱藏鍵盤";
            }
            sender.isSelected = true
        }
        else{
            //移除鍵盤相關通知
            NotificationCenter.default.removeObserver(keyboardShowNotification!)
            NotificationCenter.default.removeObserver(keyboardHideNotification!)
            sender.isSelected = false
        }
    }
    
    @IBAction func regionNotificationSend(_ sender: Any) {
        let sendDic = getSendData()
        let name = NSNotification.Name("regionNotification")
        NotificationCenter.default.post(name: name, object:sendDic)
    }
    
    func getSendData()->Dictionary<String,String>{
        var sendDic = [String:String]()
        sendDic["msg"] = msgTextField.text
        sendDic["sender"] = "畫面2"
        return sendDic
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        //使用view內建的「endEditing(_: )」函式結束編輯狀態
        view.endEditing(true)
    }
}



//
//  thirdVC.swift
//  lab9
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class thirdVC: UIViewController {
    @IBOutlet var sender: UILabel!
    @IBOutlet var msg: UILabel!
    @IBOutlet var timeLabel: UILabel!
    var publicNotification : NSObjectProtocol?
    var regionNotification : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNotification()
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
        let hour = timeData["hour"]
        let min = timeData["min"]
        let sec = timeData["sec"]
        timeLabel.text = String(format:"%02d:%02d:%02d",hour ?? 0,min ?? 0,sec ?? 0)
    }
    
    func showMsg(_ msgData:Dictionary<String,String>){
        sender.text = msgData["sender"]
        msg.text = msgData["msg"]
    }
}


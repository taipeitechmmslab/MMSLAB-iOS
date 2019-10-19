//
//  ViewController.swift
//  lab6_exercise
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func demoAlertActionSheet(_ sender: Any) {
        let actionSheetController = UIAlertController(title: "標題", message: "說明", preferredStyle:.actionSheet)
        let commonAction = UIAlertAction(title: "預設樣式", style: .default)
        let destructiveAction = UIAlertAction(title: "危險樣式", style: .destructive)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        actionSheetController.addAction(commonAction)
        actionSheetController.addAction(destructiveAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true)
    }
    
    @IBAction func demoAlertView(_ sender: Any) {
        let alertController = UIAlertController(title: "標題", message: "說明", preferredStyle:.alert)
        let commonAction = UIAlertAction(title: "預設樣式", style: .default)
        let destructiveAction = UIAlertAction(title: "危險樣式", style: .destructive)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        alertController.addAction(commonAction)
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        let alertController = UIAlertController(title: "登入", message: "輸入帳號密碼", preferredStyle:.alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "請輸入帳號"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "請輸入密碼"
            textField.isSecureTextEntry = true
        }
        let determineAction = UIAlertAction(title: "確定", style: .default) { (action) in
            let account = alertController.textFields![0]
            let password = alertController.textFields![1]
            self.showLogin(account.text!, password.text!)
        }
        let cancelAction = UIAlertAction(title:"取消", style:.cancel)
        alertController.addAction(determineAction)
        alertController.addAction(cancelAction)
        present(alertController, animated:true)
    }
    
    func showLogin(_ account:String,_ password:String){
        let msgView = UIAlertController(title: "登入成功", message: String(format:"帳號：%@\n密碼：%@",account,password), preferredStyle:.alert)
        let determineAction = UIAlertAction(title: "確定", style: .default)
        msgView.addAction(determineAction)
        present(msgView, animated:true)
    }
    
    @IBAction func showCustomPopup(_ sender: Any) {
        //宣告VC為customPopupViewController
        let VC = customPopupViewController()
        //設定Closure
        VC.selectHandler = { (name:String)->() in
            //使用Alert顯示傳入的字串
            self.showStringData(str: name)
        }
        //顯示Popup View
        VC.showInVC(VC: self)
    }
    
    func showStringData(str:String){
        //使用Alert顯示輸入的字串
        let msgView = UIAlertController(title: str, message:nil, preferredStyle:.alert)
        let determineAction = UIAlertAction(title: "確定", style: .default)
        msgView.addAction(determineAction)
        present(msgView, animated: true)
    }
}


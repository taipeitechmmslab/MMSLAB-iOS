//
//  ViewController.swift
//  lab6-1-1
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        
        let actionSheetController = UIAlertController(title: "登入", message: "輸入帳號密碼", preferredStyle:.alert)
        actionSheetController.addTextField { (textField) in
            textField.placeholder = "請輸入帳號"
        }
        actionSheetController.addTextField { (textField) in
            textField.placeholder = "請輸入密碼"
            textField.isSecureTextEntry = true
        }
        
        let determineAction = UIAlertAction(title: "確定", style: .default) { (action) in
            let account = actionSheetController.textFields?[0]
            let password = actionSheetController.textFields?[1]
            self.showLoginAccount(account: account?.text ?? "", password: password?.text ?? "")
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        actionSheetController.addAction(determineAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    
    
    func showLoginAccount(account:String,password:String){
        let msgView = UIAlertController(title: "登入成功", message: String(format:"帳號：%@ 密碼：%@",account,password), preferredStyle:.alert)
        let determineAction = UIAlertAction(title: "確定", style: .default,handler: nil)
        msgView.addAction(determineAction)
        present(msgView, animated: true, completion: nil)
    }
    
}


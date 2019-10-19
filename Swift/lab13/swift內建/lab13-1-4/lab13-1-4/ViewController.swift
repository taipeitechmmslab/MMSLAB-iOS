//
//  ViewController.swift
//  lab13-1-4
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func GetAPIData(){
        let usrString = "https://jsonplaceholder.typicode.com/comments?postId=1"
        let url = URL(string: usrString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                print("發送失敗 ",error!.localizedDescription)
            }
            else{
                print("發送成功")
                let str = String(data: data!, encoding: .utf8)
                print(str ?? "")
            }
        }
        task.resume()
    }
    
    func PostAPIData(jsonData:Data) {
        //使用字串建立一個URL參數
        let usrString = "https://gurujsonrpc.appspot.com/guru"
        let url = URL(string: usrString)
        //使用URL初始化Request參數
        var request = URLRequest(url: url!)
        //將此Request的傳遞方式設定為Post
        request.httpMethod = "POST"
        //使用Json格式的字串設定Request的Body資料
        request.httpBody = jsonData
        //使用request與Closure初始化task，並設定Closure內的程式
        let task = URLSession.shared.dataTask(with:request){ data, response, error in
            //在此設定收到回傳資料（data）或錯誤訊息（error）時執行的動作
            if(error != nil){
                print("發送失敗 ",error!.localizedDescription)
            }
            else{
                print("發送成功")
                let str = String(data: data!, encoding: .utf8)
                print(str ?? "")
            }
        }
        //啟動此task執行Http連線
        task.resume()
    }
}

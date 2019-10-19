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

    class func GetAPIData(apiName:String){
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
    
    class func PostAPIData(json:String) {
        
        let usrString = "https://gurujsonrpc.appspot.com/guru"
        let url = URL(string: usrString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
}


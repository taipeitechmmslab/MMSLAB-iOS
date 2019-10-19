//
//  ViewController.swift
//  lab13-1-3
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit


class DataModel : Codable{
    var myNumber = 0
    var myString = ""
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonData = encoder()
        decoder(jsonData: jsonData)
    }
    
    func encoder()->Data{
        //Step1:建立一個物件，並放入資料至物件中
        let data = DataModel()
        data.myNumber = 123
        data.myString = "abc"
        //Step2:使用「JSONEncoder()」的「encode()」函式將物件轉為Json資料
        let jsonData = try? JSONEncoder().encode(data)
        
        if let jsonStr = String(data: jsonData!, encoding: .utf8){
            print("jsonStr = ",jsonStr)
        }
        return jsonData!
    }
    
    func decoder(jsonData:Data){
        //Step1:準備一個JSON字串，並將其轉為Data
        let stringData = "{\"myString\":\"abc\",\"myNumber\":123}".data(using: .utf8)!
        //Step2：使用「JSONDecoder()」的「decode()」將輸入的Json Data以DataModel的格式做轉換並輸出
        let data = try? JSONDecoder().decode(DataModel.self, from:stringData)
        print("myNumber = ",data?.myNumber ?? "","myString =", data?.myString ?? "")
    }
}



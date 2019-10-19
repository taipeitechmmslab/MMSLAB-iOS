//
//  ViewController.swift
//  lab13-1-3
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
import YYModel

class Data : NSObject{
    @objc var myNumber = 0
    @objc var myString = ""
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        encoder()
        decoder()
        
    }
    
    func encoder(){
        let data = Data()
        data.myNumber = 123
        data.myString = "abc"
        let json = data.yy_modelToJSONString()
        print(json ?? "")
    }
    
    func decoder(){
        let json = "{\"myString\":\"abc\",\"myNumber\":123}"
        let data = Data.yy_model(withJSON: json)
        print("myString =",data?.myString ,"myNumber =", data?.myNumber)
    }
}


//
//  ViewController.swift
//  lab2-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var userSelectSegment: UISegmentedControl!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var mySelectLabel: UILabel!
    @IBOutlet var pcSelectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startBtnClick(_ sender: Any) {
        if(nameField.text != ""){
            nameLabel.text = String(format:"名字\n%@",nameField.text!)
            let myIndex = userSelectSegment.selectedSegmentIndex
            let mySelect = getSelectBy(index:myIndex)
            mySelectLabel.text = String(format:"我方出拳\n%@",mySelect)
            let pcIndex = Int.random(in: 0...2)
            
            //接收的變數 = 副程式名稱(輸入參數的名稱:輸入的參數)
            let pcSelect = getSelectBy(index:pcIndex)
            
            
            pcSelectLabel.text = String(format:"電腦出拳\n%@",pcSelect)
            showWinnerBy(myIndex: myIndex, pcIndex: pcIndex)
        }
        else{
            textLabel.text = "請輸入玩家姓名"
        }
    }
    
    //func 副程式名稱(輸入參數的名稱:輸入參數類別)->輸出的類別
    func getSelectBy(index:Int)->String{
        //出拳 index = 0:剪刀 1:石頭 2:布
        return userSelectSegment.titleForSegment(at: index)!
    }
    
    func showWinnerBy(myIndex:Int,pcIndex:Int){
        //判斷勝負
        if(myIndex == pcIndex){
            textLabel.text = "平手，再試一次"
            winnerLabel.text = "勝利者\n平手"
        }
        else if((myIndex == 0 && pcIndex == 2) ||
                (myIndex == 1 && pcIndex == 0) ||
                (myIndex == 2 && pcIndex == 1)){
            textLabel.text = "恭喜你獲得勝利！！！"
            winnerLabel.text = String(format:"勝利者\n%@",nameField.text!)
        }
        else{
            textLabel.text = "可惜，電腦獲勝了"
            winnerLabel.text = "勝利者\n電腦"
        }
    }
}


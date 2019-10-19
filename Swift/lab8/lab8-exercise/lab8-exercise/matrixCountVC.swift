//
//  matrixCountVC.swift
//  lab8-exercise
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class matrixCountVC: UIViewController {
    @IBOutlet var matrix1Label: UILabel!
    @IBOutlet var matrix2Label: UILabel!
    @IBOutlet var matrix3Label: UILabel!
    @IBOutlet var startBtn: UIButton!
    var matrix1 = [[Int]]()
    var matrix2 = [[Int]]()
    var matrix3 = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createMatrix(_ sender: UIButton) {
        startBtn.isEnabled = false
        //初始化兩個陣列
        matrix1 = [[Int]]()
        matrix2 = [[Int]]()
        //使用For迴圈在matrix1中新增一維陣列，達到二維矩陣的效果
        for _ in 0...9{
            let tempArr = [Int]()
            matrix1.append(tempArr)
        }
        //使用For迴圈在matrix2中新增一維陣列，達到二維矩陣的效果
        for _ in 0...9{
            let tempArr = [Int]()
            matrix2.append(tempArr)
        }
        //清空顯示矩陣的Label
        matrix1Label.text = ""
        matrix2Label.text = ""
        //初始化佇列與佇列組
        let mainQueue = DispatchQueue.main
        let secQueue = DispatchQueue.global()
        let gtoupQueue = DispatchGroup()
        print("開始")
        //新增矩陣一內的元素
        secQueue.async(group: gtoupQueue){
            for row in 0...9{
                for _ in 0...9{
                    //產生1~9的隨機亂數並加入至矩陣中
                    let element = Int.random(in: 1...9)
                    self.matrix1[row].append(element)
                    usleep(50000)//休息50ms
                    self.showMatrix(index: 1, data: element)
                }
                self.showMatrix(index: 1)
            }
        }
        //新增矩陣二內的元素
        secQueue.async(group: gtoupQueue){
            for row in 0...9{
                for _ in 0...9{
                    //產生1~9的隨機亂數並加入至矩陣中
                    let element = Int.random(in: 1...9)
                    self.matrix2[row].append(element)
                    usleep(80000)//休息80ms
                    self.showMatrix(index: 2, data: element)
                }
                self.showMatrix(index: 2)
            }
        }
        gtoupQueue.notify(queue: mainQueue){
            print("兩個矩陣生成完畢")
            self.matrixProduct()
        }
    }
    
    func matrixProduct(){
        //初始化第三個矩陣與顯示的Label
        matrix3Label.text = ""
        matrix3 = [[Int]]()
        for _ in 0...9{
            let tempArr = [Int]()
            matrix3.append(tempArr)
        }
        //計算矩陣相乘
        let secQueue = DispatchQueue.global()
        secQueue.async {
            for row in 0...9{
                //取得matrix1的行向量
                let matrix1Row = self.matrix1[row]
                for col in 0...9{
                    //透過For迴圈取得matrix2的列向量
                    var matrix2Col = [Int]()
                    for i in 0...9{
                        matrix2Col.append(self.matrix2[i][col])
                    }
                    //矩陣的乘法：matrix1列向量 · matrix2行向量
                    let dotValue = self.doDot(vector1: matrix1Row, vector2: matrix2Col)
                    self.matrix3[row].append(dotValue)
                    self.showMatrix(index: 3, data: dotValue)
                    usleep(50000)
                }
                self.showMatrix(index: 3)
            }
            let mainQueue = DispatchQueue.main
            mainQueue.async {//計算完成，開啟按鈕功能
                self.startBtn.isEnabled = true
            }
        }
    }
    
    //輸入兩個向量並輸出內積的結果
    func doDot(vector1:[Int],vector2:[Int])->Int{
        var dotValue = 0
        for i in 0...9{
            dotValue+=vector1[i]*vector2[i]
        }
        return dotValue
    }
    
    //寫入資料 或 換行
    func showMatrix(index:Int,data:Int = -1){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            if(data == -1){
                if(index == 1){
                    self.matrix1Label.text!+="\n"
                }
                else if(index == 2){
                    self.matrix2Label.text!+="\n"
                }
                else{
                    self.matrix3Label.text!+="\n"
                }
            }
            else{
                if(index == 1){
                    self.matrix1Label.text!+=String(format:"%2d ",data)
                }
                else if(index == 2){
                    self.matrix2Label.text!+=String(format:"%2d ",data)
                }
                else{
                    self.matrix3Label.text!+=String(format:"%4d",data)
                }
            }
        }
    }
}

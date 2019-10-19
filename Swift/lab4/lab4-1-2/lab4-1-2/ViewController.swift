//
//  ViewController.swift
//  lab4-1-2
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self)," init")
    }
    
    override func loadView() {
        super.loadView()
        print(type(of: self)," loadView")
    }
    
    //在這個View Controller只會執行此函式一次
    override func viewDidLoad() {
        super.viewDidLoad()
        //可在此撰寫程式（初始化元件）
        print(type(of: self)," viewDidLoad")
    }
    
    //在這個View Controller出現前執行(多次)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //可在此撰寫程式（在顯示畫面前整理元件）
        print(type(of: self)," viewWillAppear")
    }
    
    //接續在viewWillAppear後執行的函式(多次)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //可在此撰寫程式（動畫效果）
        print(type(of: self)," viewDidAppear")
    }
    
    //觸發離開View Controller時會執行的函式（畫面還在）
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //可在此撰寫程式
        print(type(of: self)," viewWillDisappear")
    }
    
    //離開View Controller後會執行的函式（畫面已消失）
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //可在此撰寫程式
        print(type(of: self)," viewDidDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(type(of: self)," didReceiveMemoryWarning")
        //讀取手機使用的iOS版本
        let systemVersion = Double(UIDevice.current.systemVersion)!
        //iOS版本6.0後才需要自行釋放記憶體
        if( systemVersion >= 6.0){
            //判斷畫面是否有被載入過，並且畫面沒有出現在螢幕上
            if(isViewLoaded && view.window == nil){
                //釋放掉view的記憶體空間，使下次進入時可以呼叫viewDidLoad
                view = nil
            }
        }
    }
    
    
    func loadStoryBoardVC(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(identifier: "ViewController")
        print(VC)
    }
        
    func loadXibVCWithNibName(){
        let VC = ViewController.init(nibName: "OtherVC", bundle: nil)
        print(VC)
    }
    
    func loadXibVC(){
        let VC = ViewController()
        print(VC)
    }
    
    @IBAction func nextpage(_ sender: Any) {
        print("使用者觸發下一頁")
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(identifier: "SecViewController")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

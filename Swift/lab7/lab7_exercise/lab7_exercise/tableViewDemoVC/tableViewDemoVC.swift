//
//  tableViewDemoVC.swift
//  lab7-1-2
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class tableViewDemoVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    var fruitNameArr : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化Table View
        tableViewInit()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //初始化水果名稱的陣列，使用NSUserDefaults呼叫之前設定的陣列
        let userDefault = UserDefaults.standard
        fruitNameArr = userDefault.value(forKey: "fruitName") as? [String]
    }
    
    func tableViewInit(){
        //可參考7-1-1的「註冊Table View Cell」
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseCell")
        let cellNib = UINib(nibName: "myTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myTableViewCell")
    }
}

extension tableViewDemoVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 ){
            return fruitNameArr?.count ?? 0
        }
        else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! myTableViewCell
            let fruit = fruitNameArr?[indexPath.row]
            cell.setCell(imgName: fruit ?? "", title: fruit ?? "")
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
            cell.textLabel?.text = String(format:"第%d個cell",indexPath.row)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if(section == 0 ){
            return "客製化 table view cell"
        }
        else{
            return "系統內建 table view cell"
        }
    }
}

extension tableViewDemoVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        //設定section上方的高度
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //使用print()顯示出被點擊Cell的小節（section）與項目序號（row）
        print("你點擊了",indexPath.section,"-",indexPath.row)
        //讀取Table View Cell，並使用print()顯示出Cell的高度
        let cell = tableView.cellForRow(at: indexPath)!
        print("Cell的高度為"+String(Int(cell.bounds.size.height)))
        //取消選取的動畫
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

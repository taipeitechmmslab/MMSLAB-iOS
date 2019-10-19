//
//  ViewController.swift
//  lab7-1
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInit()
    }
    
    func tableViewInit(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseCell")
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //使用print()顯示出被點擊Cell的小節（section）與項目序號（row）
        print("你點擊了",indexPath.section,"-",indexPath.row)
        //取消選取的動畫
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        //設定section上方的title
        return String(format:"section %d",section)
    }
    
    //UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int{
        //設定要幾個Section，若不設定則為1
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //設定每個小節（Section）要顯示的項目數量
        //要顯示20個Cell
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cell的重複利用機制
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        //設置Cell的顯示文字
        cell.textLabel?.text = String(format:"第%d個cell",indexPath.row)
        //輸出設定完成的Cell
        return cell
    }
}


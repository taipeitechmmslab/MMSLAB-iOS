//
//  ViewController.swift
//  lab13-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
import YYModel


class MRTModel : NSObject{
    @objc var result : resultModel?
}

class resultModel : NSObject,YYModel{
    @objc var results : [infoModel]?
    
    @objc static func modelContainerPropertyGenericClass() ->[String : AnyObject]? {
        return ["results":infoModel.self]
    }
}

class infoModel : NSObject{
    @objc var Station : String?
    @objc var Destination : String?
}

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var data : MRTModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseCell")
    }


    @IBAction func getDataFromApi(_ sender: Any) {
        let usrString = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=55ec6d6e-dc5c-4268-a725-d04cc262172b"
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
                
                DispatchQueue.main.async {
                    self.data = MRTModel.yy_model(withJSON: data!)
                    self.tableView.reloadData()
                }
            }
            
        }
        task.resume()
    }
}



extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.result?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        let info = data?.result?.results?[indexPath.row]
        cell.textLabel?.text = String(format:"%@ %@",info?.Station ?? "",info?.Destination ?? "")
        return cell
    }
    
    
}

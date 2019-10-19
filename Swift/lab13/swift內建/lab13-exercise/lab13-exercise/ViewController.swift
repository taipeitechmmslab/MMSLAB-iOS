//
//  ViewController.swift
//  lab13-exercise
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    class MRTModel :Codable{
        var result : result
    }
    
    class result :Codable {
        var results : [results]
    }
    
    class results :Codable{
        var Station : String
        var Destination : String
    }
    
    @IBOutlet var tableView: UITableView!
    var myData : MRTModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                DispatchQueue.main.async {
                    do{
                        self.myData = try JSONDecoder().decode(MRTModel.self, from: data!)
                        self.tableView.reloadData()
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.result.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:"reuseCell")
        //若沒讀取到則自己初始化一個Table View Cell
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        }
        let info = myData?.result.results[indexPath.row]
        cell!.textLabel?.text = info?.Station ?? ""
        cell!.detailTextLabel?.text = info?.Destination ?? ""
        return cell!
    }
}



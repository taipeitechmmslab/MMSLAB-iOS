//
//  ViewController.swift
//  lab12-exercise
//
//  Created by taizhou on 2019/7/31.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
import Toast
import RealmSwift

class bookTable : Object{
    @objc dynamic var bookName = ""
    @objc dynamic var price = 0
}

class ViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var bookTableArr : Results<bookTable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讀取資料庫中的bookTable內所有資料
        let realm = try! Realm()
        bookTableArr = realm.objects(bookTable.self)
        //使用print打印出資料庫的檔案位置
        print(realm.configuration.fileURL!.deletingLastPathComponent().path)
    }


    @IBAction func addNewBook(_ sender: Any) {
        //判斷是否有輸入書名，沒有就使用Toast顯示提醒
        if(nameTextField.text == ""){
            view.makeToast("請輸入書名")
            return
        }
        let bookData = bookTable()
        bookData.bookName = nameTextField.text ?? ""
        bookData.price = Int(priceTextField.text ?? "0") ?? 0
        let realm = try! Realm()
        try! realm.write {
            realm.add(bookData)
        }
        bookTableArr = realm.objects(bookTable.self)
        tableView.reloadData()
        view.makeToast(String(format:"新增書名：%@價格：%d",bookData.bookName,bookData.price))
    }
    
    @IBAction func editBook(_ sender: Any) {
        if(nameTextField.text == ""){
            view.makeToast("請輸入書名")
            return
        }
        let realm = try! Realm()
        let searchDatas = realm.objects(bookTable.self).filter("bookName == %@",nameTextField.text!)
        try! realm.write {
            for searchData in searchDatas{
                searchData.price =  Int(priceTextField.text!) ?? 0
            }
        }
        bookTableArr = realm.objects(bookTable.self)
        tableView.reloadData()
        view.makeToast(String(format:"將%@價格編輯為%@元",nameTextField.text!,priceTextField.text!))
    }
    
    @IBAction func removeBook(_ sender: Any) {
        if(nameTextField.text == ""){
            view.makeToast("請輸入書名")
            return
        }
        let realm = try! Realm()
        let searchDatas = realm.objects(bookTable.self).filter("bookName == %@",nameTextField.text!)
        try! realm.write {
            realm.delete(searchDatas)
        }
        bookTableArr = realm.objects(bookTable.self)
        tableView.reloadData()
        view.makeToast(String(format:"將%@移除",nameTextField.text!))
    }
    
    @IBAction func searchBook(_ sender: Any) {
        let realm = try! Realm()
        if(nameTextField.text == ""){
            bookTableArr = realm.objects(bookTable.self)
            
        }
        else{
            bookTableArr = realm.objects(bookTable.self).filter("bookName == %@",nameTextField.text!)
        }
        tableView.reloadData()
        view.makeToast(String(format:"共有%d筆資料",bookTableArr?.count ?? 0))
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookTableArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:"reuseCell")
        //若沒讀取到則自己初始化一個Table View Cell
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseCell")
        }
        cell!.detailTextLabel?.text = String(format:"售價%d元",(bookTableArr?[indexPath.row].price)!)
        cell!.textLabel?.text = bookTableArr?[indexPath.row].bookName
        return cell!
    }
}



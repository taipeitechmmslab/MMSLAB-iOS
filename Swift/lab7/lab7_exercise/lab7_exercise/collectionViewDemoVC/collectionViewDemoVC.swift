//
//  collectionViewDemoVC.swift
//  lab7_exercise
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class collectionViewDemoVC: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var fruitNameArr : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //初始化水果名稱的陣列，使用NSUserDefaults呼叫之前設定的陣列
        let userDefault = UserDefaults.standard
        fruitNameArr = userDefault.value(forKey: "fruitName") as? [String]
    }
    
    func collectionViewInit(){
        //註冊CollectionViewCell與RusableView
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        let cellNib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "myCollectionViewCell")
    }
}

extension collectionViewDemoVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        //設定此Collection View含有兩個Section
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //設定Section0有與水果名稱陣列相同的數量，Section1顯示20個Cell
        if(section == 0){
            return fruitNameArr?.count ?? 0
        }
        else{
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Section0顯示客製化的Cell，Section1顯示系統原生的Cell
        if(indexPath.section == 0){
            //可參考7-1-4的Step6
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
            cell.setCell(imgName: fruitNameArr?[indexPath.row] ?? "", title: fruitNameArr?[indexPath.row] ?? "")
            return cell
        }
        else{
            //可參考7-1-3的「collectionView(_:, cellForItemAt: )」函式介紹
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath)
            cell.backgroundColor = UIColor(red: 10*CGFloat(indexPath.row)/255, green: 20*CGFloat(indexPath.row)/255, blue: 30*CGFloat(indexPath.row)/255, alpha: 1)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            label.textAlignment = .center
            label.text = String(format:"%d",indexPath.row)
            label.textColor = UIColor.red
            for subview in cell.contentView.subviews{
                subview.removeFromSuperview()
            }
            cell.contentView.addSubview(label)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        //設置Collection View的Header，可參考7-1-3的「collectionView(_: ,viewForSupplementaryElementOfKind: ,at: )」函式介紹
        if(kind == UICollectionView.elementKindSectionHeader){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.bounds.size.width, height: headerView.bounds.size.height))
            label.textAlignment = .center
            if(indexPath.section == 0){
                label.text = "客製化 collection view cell"
            }
            else{
                label.text = "原生 collection view cell"
            }
            for subview in headerView.subviews{
                subview.removeFromSuperview()
            }
            headerView.addSubview(label)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension collectionViewDemoVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //點擊Cell使用print()顯示出Cell的index path，如「0-5」為Section0的第5個Cell
        print(indexPath.section,"-",indexPath.row)
    }
}

extension collectionViewDemoVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //設定兩個Section中Cell的大小
        if(indexPath.section == 0){
            let width = Int((collectionView.bounds.size.width-20)/3)
            let height = Int(CGFloat(width)*1.5)
            return CGSize(width: width, height: height)
        }
        else{
            let width = Int((collectionView.bounds.size.width-40)/5)
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        //設定上下間距為10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        //設定左右間距為10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        //設定Section Header的大小
        let width = collectionView.bounds.size.width
        return CGSize(width: width, height: 50)
    }
}

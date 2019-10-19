//
//  ViewController.swift
//  lab7-1-3
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewInit()
    }

    func collectionViewInit(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
}
 
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //點選後的執行動作
        print(indexPath.section,"-",indexPath.row)
    }
}

extension ViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //設定每個小節（Section）要顯示的項目數量
        //要顯示20個Cell
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 10*CGFloat(indexPath.row)/255.0, green: 20*CGFloat(indexPath.row)/255.0, blue: 30*CGFloat(indexPath.row)/255.0, alpha: 1)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if(kind == UICollectionView.elementKindSectionHeader){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.bounds.size.width, height: headerView.bounds.size.height))
            label.textAlignment = .center
            label.text = String(format:"section %d",indexPath.section)
            for subview in headerView.subviews{
                subview.removeFromSuperview()
            }
            headerView.addSubview(label)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = Int((collectionView.bounds.size.width-120)/5)
        return CGSize(width: width, height: width)
    }    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        //設定Cell的上下間距為10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        //設定Cell的左右間距為30
        return 30
    }
}

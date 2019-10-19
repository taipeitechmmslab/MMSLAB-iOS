//
//  ViewController.swift
//  lab7-1-4
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    let fruitArr = ["apple", "avocado", "banana", "cherries", "coconut", "grapes", "lemon", "orange", "peach", "pineapple", "strawberry", "tomato"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewInit()
    }
    
    func collectionViewInit(){
        let cellNib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print(indexPath.section,"-",indexPath.row)
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruitArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell
        cell.setCell(imgName: fruitArr[indexPath.row], title: fruitArr[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //設置寬度為（Collection View寬度-2倍間距）/3，使一排顯示3個Cell
        let width = Int((collectionView.bounds.size.width-20)/3)
        let height = Int(CGFloat(width)*1.5)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        //上下間距為10
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        //左右間距為10
        return 10
    }
}

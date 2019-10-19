//
//  myCollectionViewCell.swift
//  lab7-1-4
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(imgName:String,title:String){
        imgView.image = UIImage(named: imgName)
        titleLabel.text = title
    }
}

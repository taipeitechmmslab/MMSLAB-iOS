//
//  myTableViewCell.swift
//  lab7-1-2
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    @IBOutlet var myImgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //原生的Table View Cell建構函式，無需做設定
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //選取Table View Cell時，Table View Cell會觸發此函式，可針對Cell的選取外觀做設計，在此無需做設定
    }
    
    func setCell(imgName:String,title:String){
        //設定Cell內的圖片（myImgView）與文字（titleLabel）
        myImgView.image = UIImage(named: imgName)
        titleLabel.text = title
    }
}

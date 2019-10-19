//
//  zoomingVC.swift
//  lab5_exercize
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class zoomingVC: UIViewController {
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension zoomingVC:UIScrollViewDelegate{
    //設定要縮放的畫面為containerView
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return containerView
    }
}

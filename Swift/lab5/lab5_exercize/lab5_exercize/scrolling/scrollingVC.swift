//
//  scrollingVC.swift
//  lab5_exercize
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class scrollingVC: UIViewController {
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension scrollingVC :UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}

//
//  SecViewController.swift
//  lab4-1-2
//
//  Created by 張力元 on 2019/8/2.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self)," init")
    }
    
    override func loadView() {
        super.loadView()
        print(type(of: self)," loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self)," viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self)," viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self)," viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self)," viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        print(type(of: self)," viewDidDisappear")
    }
    
    @IBAction func back(_ sender: Any) {
        print("使用者觸發上一頁")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func memoryrelease(_ sender: Any) {
        let VC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)!-2]
        VC?.didReceiveMemoryWarning()
    }
}

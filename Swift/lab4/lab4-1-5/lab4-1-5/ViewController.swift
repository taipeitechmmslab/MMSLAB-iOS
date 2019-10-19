//
//  ViewController.swift
//  lab4-1-5
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func nextPage(_ sender: Any) {
        
        
        
    }
    
    func presentVC(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(identifier: "SecViewController") as! SecViewController
        present(VC, animated: true, completion: nil)
    }
    
    func pushVC(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(identifier: "SecViewController") as! SecViewController
        navigationController?.pushViewController(VC, animated: true)
    }
    
}





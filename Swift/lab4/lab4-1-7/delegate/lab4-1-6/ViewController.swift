//
//  ViewController.swift
//  lab4-1-6
//
//  Created by taizhou on 2019/8/1.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showSecPage" ){
            let VC = segue.destination as! SecViewController  
            VC.data = "使用 segue 傳遞資料"
            VC.delegate = self
        }
    }
    
    
    @IBAction func nextPage(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "SecViewController") as! SecViewController
        VC.data = "使用程式碼傳遞資料"
        VC.delegate = self
        present(VC, animated: true, completion: nil)
    }
    
}

extension ViewController : SecViewControllerDelegate{
    func changeTitle(title: String) {
        self.title = title
    }
}


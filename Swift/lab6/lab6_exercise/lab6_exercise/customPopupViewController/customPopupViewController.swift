//
//  customPopupViewController.swift
//  lab6-1-2
//
//  Created by taizhou on 2019/7/29.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit

class customPopupViewController: UIViewController {
    @IBOutlet var popupView: UIView!
    var selectHandler : ((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showInVC(VC:UIViewController){
        self.modalPresentationStyle = .overCurrentContext
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        VC.view.window?.layer.add(transition, forKey: kCATransition)
        VC.present(self, animated: false) {
            self.popupView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.popupView.alpha = 0
            UIView.animate(withDuration: 0.25) {
                self.popupView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.popupView.alpha = 1
            }
        }
    }
    
    func dissMissPopupView(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dissMissPopupView()
    }
    
    @IBAction func selectFood(_ btn: UIButton) {
        dissMissPopupView()
        self.selectHandler!(btn.titleLabel!.text!)
        
    }
}






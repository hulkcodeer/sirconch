//
//  InfoViewController.swift
//  Sir.conch
//
//  Created by In Ok Park on 2021/10/02.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    @IBAction func actionBack(_ sender: UIButton) {        
        self.dismiss(animated: true)
    }
    
    @IBAction func moveMavi(_ sender: UIButton) {
        if let url = URL(string: "https://apps.apple.com/kr/app/mavi/id6572300394") {
            UIApplication.shared.open(url, options: [:])
        }
            
    }
}

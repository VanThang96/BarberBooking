//
//  ViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/25/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func handleLoginAction(_ sender: Any) {
       let navigationController = self.navigationController as! MainNavigationViewController
        navigationController.loginWithPhone()
    }
    
    @IBAction func handleJustSkipAction(_ sender: Any) {
        
    }
    
}

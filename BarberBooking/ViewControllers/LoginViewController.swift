//
//  ViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/25/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController {
    
    //MARK: Variable
    var accountKit : AccountKit!

    override func viewDidLoad() {
        super.viewDidLoad()
        // generate accountkit
        if accountKit == nil {
            accountKit = AccountKit(responseType: .accessToken)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if accountKit.currentAccessToken != nil {
            // if the user is already logged in, go to the main screen
            performSegue(withIdentifier: "segue_tabbarController", sender: self)
            
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self))
            homeVC.modalPresentationStyle = .currentContext
            homeVC.modalTransitionStyle = .crossDissolve
            self.present(homeVC, animated: true, completion: nil)*/
        }
    }

    @IBAction func handleLoginAction(_ sender: Any) {
       loginWithPhone()
    }
    @IBAction func handleJustSkipAction(_ sender: Any) {
        
    }
    private func loginWithPhone(){
        let inputState = UUID().uuidString
        let vc = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)
        vc.isSendToFacebookEnabled = true
        vc.isGetACallEnabled = true
        vc.delegate = self
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    private func prepareLoginViewController(loginViewController : AKFViewController){
        // get countryCode
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? "US"
        
        loginViewController.delegate = self
        loginViewController.defaultCountryCode = countryCode
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_tabbarController"{
            //sent data here
        }
    }
}
extension LoginViewController : AKFViewControllerDelegate {
    // To handle a successful login in Access Token mode:
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
        userDefault.set(accessToken.tokenString, forKey: "accessToken")
        
        print("===== Did complete login with access token:\(accessToken.tokenString),state:\(String(describing: state)) =====")
    }
    func viewController(_ viewController: (UIViewController & AKFViewController), didFailWithError error: Error) {
        // ... implement appropriate error handling ...
        print("\(String(describing: viewController)) did fail with error: \(error.localizedDescription)")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)) {
        // ... handle user cancellation of the login process ...
    }
}

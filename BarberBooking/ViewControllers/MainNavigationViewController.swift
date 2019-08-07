//
//  MainNavigationViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 8/5/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit
import AccountKit

class MainNavigationViewController: UINavigationController {
    
    var accountKit : AccountKit!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        // generate accountkit
        if accountKit == nil {
            accountKit = AccountKit(responseType: .accessToken)
        }
        settingFirstScreen()
    }
    
    private func settingFirstScreen(){
        
        //case logged in
        if accountKit.currentAccessToken != nil && UserDefaultsManager.isLoggedIn() {
            setRootMainScreen()
        }
        
        //case not yet register accountKit
        if accountKit.currentAccessToken == nil {
            setRootLoginScreen()
        }
    }
    
    private func setRootMainScreen(){
        let tabBarVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.viewControllers = [tabBarVC]
    }
    
    private func setRootLoginScreen(){
        let loginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.viewControllers = [loginVC]
    }
    
    private func proceedToMainScreen(){
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")as! TabBarViewController
        self.viewControllers = [mainVC]
    }
}

//MARK:- ACCOUNTKIT SET UP LOGIN WITH PHONE
extension MainNavigationViewController {
    
    public func loginWithPhone(){
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
        loginViewController.uiManager = SkinManager.init(skinType: .classic, primaryColor: UIColor(named: "#007AFF"))
        loginViewController.setTheme(Theme(primaryColor: UIColor(named: "#007AFF")!, primaryTextColor: UIColor.white, secondaryColor: UIColor.init(white: 0.95, alpha: 1.0), secondaryTextColor: UIColor.black, statusBarStyle: .default))
        
    }
}

//MARK:- AKFVIEWCONTROLLER DELEGATE
extension MainNavigationViewController : AKFViewControllerDelegate {
    // To handle a successful login in Access Token mode:
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
        
        UserDefaultsManager.setLogInStatus(status: true)
        proceedToMainScreen()
    }
    func viewController(_ viewController: (UIViewController & AKFViewController), didFailWithError error: Error) {
        // ... implement appropriate error handling ...
        print("\(String(describing: viewController)) did fail with error: \(error.localizedDescription)")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)) {
        // ... handle user cancellation of the login process ...
    }
}

//
//  TabBarViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/25/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit
import AccountKit
import Firebase

class TabBarViewController: UITabBarController {
    
    //MARK:- Variable
    var accountKit : AccountKit!
    var userRef : CollectionReference!
    var phoneNumber : String!
    
    
    //MARK:- Application Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize FireStore
        userRef = Firestore.firestore().collection("User")
        
        // check if login = true,enable full access
        //If login = false, just user arount shopping to view
        guard let accessToken = userDefault.string(forKey: "accessToken"), !accessToken.isEmpty else {return}
        
        handleUpdateProfile()
        
    }
    
    //MARK:- Method
    private func showUpdateProfileView(){
        // update user
        let updateVC = UpdateProfileViewController.instantiate(appStoryboard: .main) as! UpdateProfileViewController
        updateVC.phoneNumber = phoneNumber
        self.present(updateVC, animated: true, completion: nil)
    }
    
    fileprivate func handleUpdateProfile() {
        // initialize Account Kit
        if accountKit == nil {
            //specify AKFResponseType.AccessToken
            self.accountKit = AccountKit(responseType: .accessToken)
            accountKit.requestAccount{
                (account, error) in
                guard let account = account else {return}
                
                let docRef = self.userRef.document(account.phoneNumber?.stringRepresentation() ?? "")
                docRef.getDocument(completion: { [weak self](snapShot, error) in
                    if let document = snapShot, document.exists {
                        let result = document.data().map({ (document) -> User in
                            if let user = User(dictionary: document) {
                                return user
                            } else {
                                fatalError("===== Unable to initialize type \(User.self) with dictionary \(document) =====")
                            }
                        })
                    } else {
                        guard let phone = account.phoneNumber?.stringRepresentation(),!phone.isEmpty else{
                            print("===== PhoneNumber is not exists =====")
                            return
                        }
                        self?.phoneNumber = phone
                        self?.showUpdateProfileView()
                    }
                })
            }
        }
    }
}



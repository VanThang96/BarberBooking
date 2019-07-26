//
//  UpdateProfileViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/26/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    var userRef : CollectionReference!
    var phoneNumber : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize Firestore
        userRef = Firestore.firestore().collection("User")
        
    }
    @IBAction func handleUpdateProfileAction(_ sender: Any) {
        // updateProfile
        handleUpdateProfile()
        dismiss(animated: true, completion: nil)
    }
    
    private func handleUpdateProfile(){
        guard let name = txtName.text, !name.isEmpty else {return}
        guard let address = txtAddress.text, !address.isEmpty else {return}
        guard !phoneNumber.isEmpty else {return}
        
        let user = User(name: name, address: address, phoneNumber: phoneNumber).dictionary
        
        SVProgressHUD.svProgressHUB()
        SVProgressHUD.show()
        
        userRef.document(phoneNumber).setData(user) { (error) in
            if let err = error {
                print("Error writing document: \(err)")
                SVProgressHUD.dismiss()
            } else {
                print("Document successfully written!")
                SVProgressHUD.dismiss()
            }
        }
    }
}

//
//  User.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/26/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation

struct User {
    let name : String
    let address : String
    let phoneNumber : String
    
    init(name :String , address : String,phoneNumber : String){
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
    }
    var dictionary: [String: Any] {
        return [
            "name": name,
            "address" : address,
            "phoneNumber": phoneNumber
        ]
    }
}
extension User{
    init?(dictionary : [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let address = dictionary["address"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? String else {return nil}
        
        self.init(name: name, address: address, phoneNumber: phoneNumber)
    }
}

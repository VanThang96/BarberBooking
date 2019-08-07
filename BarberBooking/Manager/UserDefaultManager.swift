//
//  UserDefault.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 8/5/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation

//UserDefaults Key
enum UserDefaultsKey: String {
    case logInKey               = "logInKey"
}

class UserDefaultsManager : NSObject {
    
    static func isLoggedIn() -> Bool {
        if let isLogin = UserDefaults.standard.value(forKey: UserDefaultsKey.logInKey.rawValue) as? Bool {
            return isLogin
        }
        return false
    }
    
    static func setLogInStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: UserDefaultsKey.logInKey.rawValue)
        UserDefaults.standard.synchronize()
    }
}


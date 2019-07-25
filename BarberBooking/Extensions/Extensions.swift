//
//  Extensions.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/25/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import UIKit


let userDefault = UserDefaults.standard

enum AppStoryboard : String{
    case main = "Main"
}

extension UIViewController{
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

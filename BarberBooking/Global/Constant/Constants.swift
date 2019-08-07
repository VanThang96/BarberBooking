//
//  Constants.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 8/5/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import UIKit

enum Message {
    
    case CMSG01_Empty(itemName: String)
    case CMSG02_Invalid(itemName: String)
    case CMSG03_EnableLocationSetting
    case CMSG04_UnknownError
    case CMSG05_NetworkError
    case CMSG06_CanNotGetBankList
    case CMSG07_AccountAlreadyTaken
    case CMSG08_AccountKitTokenExpired
    case CMSG09_GetNearbyAddressNoResults
    case CMSG10_EmptyProductionLists
    case CMSG11_ImageTooLarge
    case CMSG12_TokenExpired
    
    var Description: String {
        switch self {
        case .CMSG01_Empty(let itemName):
            return "Xin vui lòng nhập " + itemName
        case .CMSG02_Invalid(let itemName):
            return "Xin vui lòng nhập " + itemName + " hợp lệ"
        case .CMSG03_EnableLocationSetting:
            return "QHTQ cần cho phép truy cập vị trí của bạn để tạo đơn hàng"
        case .CMSG04_UnknownError:
            return "Lỗi không xác định"
        case .CMSG05_NetworkError:
            return "Không thể kết nối đến Internet"
        case .CMSG06_CanNotGetBankList:
            return "Không thể lấy danh sách ngân hàng"
        case .CMSG07_AccountAlreadyTaken:
            return "Số điện thoại đã được đăng ký, xin vui lòng nhập số điện thoại khác"
        case .CMSG08_AccountKitTokenExpired:
            return "Phiên hoạt động đã hết hạn, xin vui lòng đăng nhập lại"
        case .CMSG09_GetNearbyAddressNoResults:
            return "Không tìm thấy nơi gửi hàng nào gần bạn"
        case .CMSG10_EmptyProductionLists:
            return "Xin vui lòng nhập đầy đủ thông tin hàng hoá và tổng trọng lượng"
        case .CMSG11_ImageTooLarge:
            return "Kích thước ảnh quá lớn, vui lòng chọn lại"
        case .CMSG12_TokenExpired:
            return "Phiên làm việc đã hết hạn, vui lòng đăng nhập lại để tiếp tục sử dụng"
        }
    }
}

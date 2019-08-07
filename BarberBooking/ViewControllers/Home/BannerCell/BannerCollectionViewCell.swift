//
//  BannerCollectionViewCell.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 8/7/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvBanner: UIImageView!
    
    var banner : UIImage? {
        didSet{
            imvBanner.image = banner
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

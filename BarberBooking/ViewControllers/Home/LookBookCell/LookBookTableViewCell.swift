//
//  LookBookTableViewCell.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 8/7/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class LookBookTableViewCell: UITableViewCell {

    @IBOutlet weak var imvLookBook: UIImageView!
    
    var lookBook : UIImage?{
        didSet{
            imvLookBook.image = lookBook
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

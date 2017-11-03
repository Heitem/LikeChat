//
//  UserCell.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 11/2/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firstNameLbl.text = user.firstName
    }
    
    func setCheckmark(selected: Bool) {
        let imageStr = selected ? "messegeIndicatorChecked1" : "messageIndicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }
}

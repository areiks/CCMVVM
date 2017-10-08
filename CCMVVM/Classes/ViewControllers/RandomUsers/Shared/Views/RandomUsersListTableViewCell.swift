//
//  RandomUsersListTableViewCell.swift
//  CCMVVM
//
//  Created by Lukasz Skierkowski on 08.10.2017.
//  Copyright © 2017 Lukasz Skierkowski. All rights reserved.
//

import UIKit

class RandomUsersListTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var favouritedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with randomUser: RandomUserModel) {
        self.titleLabel.text = randomUser.title
        self.firstNameLabel.text = randomUser.firstName
        self.lastNameLabel.text = randomUser.lastName
        self.emailLabel.text = randomUser.email
        self.favouritedImageView.image = randomUser.favourited ? #imageLiteral(resourceName: "BookmarkRibbonBlack") : #imageLiteral(resourceName: "BookmarkRibbonWhite")
    }
    
}

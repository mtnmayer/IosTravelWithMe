//
//  FavoriteViewCell.swift
//  TravelMe
//
//  Created by admin on 26/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

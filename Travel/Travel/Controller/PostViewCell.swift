//
//  PostViewCell.swift
//  Travel
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

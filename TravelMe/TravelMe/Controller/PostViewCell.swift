//
//  PostViewCell.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol FavoritePostDelegate{
    func favoriteButtonPresed(cell: PostViewCell)
}

class PostViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
       @IBOutlet weak var titleLabel: UILabel!
       @IBOutlet weak var avatar: UIImageView!
   
    @IBOutlet weak var strBtn: UIButton!
    
    var delegate: FavoritePostDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let image = UIImage(named: "background2")
//        self.backgroundColor = UIColor(patternImage:image!);

	        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        
    }
    
}

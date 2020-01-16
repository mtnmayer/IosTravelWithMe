//
//  MyPostViewCell.swift
//  TravelMe
//
//  Created by Studio on 15/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol myPostCellDelegate{
    
    func editPost(index:Int)
    func deletePost(index:Int)
}

class MyPostViewCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    var delegate:myPostCellDelegate?
    var index:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        delegate?.editPost(index: index!.row)
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        delegate?.deletePost(index: index!.row)
    }
    
}

//
//  PostInfoViewController.swift
//  Travel
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class PostInfoViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    var post:Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = post?.title
        placeLabel.text = post?.place
        descriptionLabel.text = post?.description
        avatarImg.image = UIImage(named: "avatar")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

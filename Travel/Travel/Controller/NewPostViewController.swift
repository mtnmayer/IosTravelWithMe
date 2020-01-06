//
//  NewPostViewController.swift
//  Travel
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var titleTexField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func postBtn(_ sender: UIButton) {
        
        let post = Post(title: titleTexField.text!, place: placeTextField.text!, description: descriptionText.text!, avatar: "")
        
        Model.instance.addPost(post: post)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func photoBtn(_ sender: UIButton) {
        
    }
    
}

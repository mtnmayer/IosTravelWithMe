//
//  WelcomeViewController.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background3")!)
        // Do any additional setup after loading the view.
        activity.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToHomeSegue"){
            
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let user = User(email: emailText.text!, pass: passwordText.text!)
        activity.isHidden = false
    
        Model.instance.loginUser(user: user) { (email) in
            if (email == "wrong"){
                Utilities().showAlert(title: "Error", message: "try again", vc: self)
            }else{
                
                Post.userEmail = email
                self.performSegue(withIdentifier: "goToHomeSegue", sender: self)

            }
        }
    }
}

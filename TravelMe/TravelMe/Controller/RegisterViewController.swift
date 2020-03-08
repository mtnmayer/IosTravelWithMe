//
//  RegisterViewController.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activityBtn: UIActivityIndicatorView!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityBtn.isHidden = true
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityBtn.isHidden = true
        registerBtn.isHidden = false
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
        activityBtn.isHidden = false
        registerBtn.isHidden = true
        
        let user = User(email: emailText.text!, pass: passwordText.text!)
        Model.instance.CreateUser(user: user) { (email) in
            if(email == "wrong"){
                self.activityBtn.isHidden = true
                self.registerBtn.isHidden = false
                Utilities().showAlert(title: "Error", message: "try again", vc: self)
            }else{
                Post.userEmail = email
                self.performSegue(withIdentifier: "goToWelcomeSegue", sender: self)
            }
        }
    }
}

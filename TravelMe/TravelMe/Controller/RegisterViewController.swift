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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        
        let user = User(email: emailText.text!, pass: passwordText.text!)
        Model.instance.CreateUser(user: user) { (email) in
            if(email == "wrong"){
                Utilities().showAlert(title: "Error", message: "try again", vc: self)
            }else{
                Post.userEmail = email
                self.performSegue(withIdentifier: "goToWelcomeSegue", sender: self)
            }
        }
    }
}

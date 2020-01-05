//
//  RegisterViewController.swift
//  Travel
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
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
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
        let user = User(email: emailText.text!, pass: passwordText.text!)
        Model.instance.CreateUser(user: user)
        performSegue(withIdentifier: "goToHomePageSegue", sender: self)
        
        
        
        
        
    }
    
}

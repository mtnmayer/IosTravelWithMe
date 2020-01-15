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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToHomeSegue"){
            
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let user = User(email: emailText.text!, pass: passwordText.text!)
        //activity.isHidden = false
         //Model.instance.CreateUser(user: user)
        Model.instance.loginUser(user: user) { (email) in
            if (email == "wrong"){
                //                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Me")
                //                self.navigationController?.present(vc!, animated: true, completion: nil)
                Utilities().showAlert(title: "Error", message: "try again", vc: self)
            }else{
                //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //                let secondVc = storyboard.instantiateViewController(identifier: "PostTableView")
                //                self.present(secondVc, animated: true, completion: nil)
                Post.userEmail = email
                self.performSegue(withIdentifier: "goToHomeSegue", sender: self)

            }
        }
        
//        Model.instance.loginUserwithOutCallback(user: user)
//        ModelEvents.loginEvent.observ { (email) in
//            if (email == "wrong"){
//
//            }else{
//                self.performSegue(withIdentifier: "goToHomeSegue", sender: self)
//            }
//        }
    }
}

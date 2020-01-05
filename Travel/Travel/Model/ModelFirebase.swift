//
//  ModelFirebase.swift
//  Travel
//
//  Created by admin on 04/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase


class ModelFirebase{
    
    func addPost(post:Post){
        
       // let db = Firestore.firestore()
     }
    
     func getAllPosts()->[Post]{
         
         return [Post]()
     }
    
    func createUser(email:String, password:String){
        
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: email, password: password) {
            (user, error) in
            if error != nil{
                print(error!)
            }
            else{
                print("Registration Successful!!")
                //performSegue(withIdentifier: "goToHomePageSegue", sender: self)
            }
        }
    }
}

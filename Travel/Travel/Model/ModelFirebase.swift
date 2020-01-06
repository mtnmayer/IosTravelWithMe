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
        
        let db = Firestore.firestore()
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(data: post.toJson()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        let db = Firestore.firestore()

        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var data = [Post]()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    data.append(Post(json:document.data()))
                }
                callback(data)
            }
        }
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

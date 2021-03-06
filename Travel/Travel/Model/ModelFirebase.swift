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
                ModelEvents.postDataEvent.post()
            }
        }
    }
    
    func getAllPosts(since:Int64, callback:@escaping ([Post]?)->Void){
        let db = Firestore.firestore()

        db.collection("posts").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil)
            } else {
                var data = [Post]()
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdate"] as? Timestamp{
                        let tsDate = ts.dateValue()
                        print("\(tsDate)")
                        let tsDouble = tsDate.timeIntervalSince1970
                        print("\(tsDouble)")
                    }
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

//
//  ModelFirebase.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase


class ModelFirebase{
    
    func addPost(post:Post){
        
        let db = Firestore.firestore()
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        //let json = post.toJson()
        ref = db.collection("posts").addDocument(data: post.toJson()) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                Post.postID = ref?.documentID
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
                    print(document.data().keys)
                    if let ts = document.data()["lastUpdate"] as? Timestamp{
                        let tsDate = ts.dateValue()
                        print("\(tsDate)")
                        let tsDouble = tsDate.timeIntervalSince1970
                        print("\(tsDouble)")
                    }
                    print("\(document.documentID)")
                    Post.postID = document.documentID
                    data.append(Post(json:document.data()))
                }
                callback(data)
            }
        }
    }
    var postID:String?
    
    func getMyPosts(callback:@escaping ([Post]?)->Void){
        let db = Firestore.firestore()
        
        db.collection("posts").order(by: "email").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil)
            } else {
                var data = [Post]()
                var i:Int = 0
                for document in querySnapshot!.documents {
                    data.append(Post(json:document.data()))
                   // print("\(document.documentID) => \(document.data())")
                    //self.postID = document.documentID
                    data[i].postId = document.documentID
                    i+=1
                }
                callback(data)
            }
        }
    }
    
    func deleteMyPost(postID:String){
        let db = Firestore.firestore()
        
        db.collection("posts").document(postID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func updateMyPost(postId:String, post:Post){
        let db = Firestore.firestore()
        let postRef = db.collection("posts").document(postId)

        // Set the "capital" field of the city 'DC'
        postRef.updateData(post.toJson()) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                ModelEvents.postDataEvent.post()

            }
        }
    }
    
    
    func createUser(email:String, password:String, callback: @escaping (String)->Void){
        
        //TODO: Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: email, password: password) {
            (user, error) in
            if error != nil{
                print(error!)
                callback("wrong")
            }
            else{
                print("Registration Successful!!")
                //performSegue(withIdentifier: "goToRegisterSegue", sender: self)
                print("Log in successful!")
                var user = Auth.auth().currentUser
                if let user = user{
                    let email = user.email
                }
                callback(email)
            }
        }
    }
    
    func loginUser(email:String, password:String, callback:@escaping (String)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!)
                callback("wrong")
            }else{
                print("Log in successful!")
                var user = Auth.auth().currentUser
                if let user = user{
                    let email = user.email
                }
                callback(email)
            }
        }
    }
    
    func loginUserwithOutCallback(email:String, password:String){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!)
                ModelEvents.loginEvent.post(data: "wrong")
            }else{
                print("Log in successful!")
                var user = Auth.auth().currentUser
                if let user = user{
                    let email = user.email
                }
                ModelEvents.loginEvent.post(data: email)
            }
        }
    }
}

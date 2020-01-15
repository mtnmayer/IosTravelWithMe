//
//  Model.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class Model{
    
    static let instance = Model()
    
    var modelSql:ModelSql = ModelSql()
    var modelFirebase:ModelFirebase = ModelFirebase()
   // var data = [Post]()
    
    private init(){
//        modelSql.setLastUpdate(name: "POSTS", lastUpdated: 12)
//        let lud = modelSql.getLastUpdateDate(name: "POSTS")
//        print("\(lud)")
    }
    
    func addPost(post:Post){
        //data.append(post)
       // modelSql.addPost(post: post)
        modelFirebase.addPost(post: post)
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        
        let lud = modelSql.getLastUpdateDate(name: "POSTS")
        
        modelFirebase.getAllPosts(since: lud) { (data) in

            var lud:Int64 = 0
            for post in data!{
                self.modelSql.addPost(post: post)
                if post.lastUpdate! > lud{
                    lud = post.lastUpdate!
                }
            }
            self.modelSql.setLastUpdate(name: "POSTS", lastUpdated: lud)
            let finalData = self.modelSql.getAllPosts()
            callback(finalData)
        }
      //  modelFirebase.getAllPosts(callback: callback)
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
                                                          
    
    func CreateUser(user:User, callback: @escaping (String)->Void){
        
        modelFirebase.createUser(email: user.email, password: user.password, callback:callback)
        
    }
    
    func loginUser(user:User, callback: @escaping (String)->Void){
    modelFirebase.loginUser(email:user.email, password:user.password, callback: callback)
    }
    
    func loginUserwithOutCallback(user:User){
        
         modelFirebase.loginUserwithOutCallback(email: user.email, password: user.password)
        
    }
}

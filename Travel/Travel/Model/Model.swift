//
//  Model.swift
//  Travel
//
//  Created by admin on 04/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import UIKit

class Model{
    
    static let instance = Model()
    
    var modelSql:ModelSql = ModelSql()
    var modelFirebase:ModelFirebase = ModelFirebase()
   // var data = [Post]()
    
    private init(){
        modelSql.setLastUpdate(name: "POSTS", lastUpdated: 12)
        let lud = modelSql.getLastUpdateDate(name: "POSTS")
        print("\(lud)")
    }
    
    func addPost(post:Post){
        //data.append(post)
       // modelSql.addPost(post: post)
        modelFirebase.addPost(post: post)
    }
    
    func getAllPosts(callback:@escaping ([Post]?)->Void){
        
        let lud = modelSql.getLastUpdateDate(name: "POSTS")
      //  modelFirebase.getAllPosts(since: <#T##Int64#>, callback: <#T##([Post]?) -> Void#>,callback: callback)
        //return modelSql.getAllPosts()
         //modelFirebase.getAllPosts()
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
                                                          
    
    func CreateUser(user:User){
        
        modelFirebase.createUser(email: user.email, password: user.password)
        
        
    }
    
}

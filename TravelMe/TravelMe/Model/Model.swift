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
        
        //get the local last update date
        var lud = modelSql.getLastUpdateDate(name: "POSTS")
        let num = modelSql.getNumOfPosts(name: "POSTS")
        
        //get the cloud updates since the local update date
        modelFirebase.getAllPosts(since:lud) { (data) in
            //insert update to the local db
           // var lud:Int64 = 0;
            for post in data!{
                self.modelSql.addPost(post: post)
                if post.lastUpdate! > lud {
                    lud = post.lastUpdate!
                }
            }
            //update the posts local last update date
            self.modelSql.setLastUpdate(name: "POSTS", lastUpdated: lud)
            self.modelSql.setNumOfPosts(num: data!.count+num, name: "POSTS")
            
            // get the complete student list
            let finalData = self.modelSql.getAllPosts()
            callback(finalData);
        }
    }
    
    
    //    func getAllPosts(callback:@escaping ([Post]?)->Void){
    //
    //        let lud = modelSql.getLastUpdateDate(name: "POSTS")
    //        modelFirebase.getAllPosts(since: lud) { (data) in
    //
    //            let num = self.modelSql.getNumOfPosts(name: "POSTS")
    //            if(num != 0){
    //                Post.numberOfPosts = num
    //            }
    //            var lud:Int64 = 0
    //            var i:Int = 0
    //            for post in data!{
    //
    //                if (num == 0){
    //                    Post.numberOfPosts = num+1
    //                    self.modelSql.addPost(post: post)
    //                    if post.lastUpdate! > lud{
    //                        lud = post.lastUpdate!
    //                        self.modelSql.setNumOfPosts(num: num+1,name: "POSTS")
    //                    }
    //                }else if ((data?.index(after: i))! > 1){
    //                    Post.numberOfPosts = num+1
    //                    self.modelSql.addPost(post: post)
    //                    if post.lastUpdate! > lud{
    //                        lud = post.lastUpdate!
    //                        self.modelSql.setNumOfPosts(num: num+1,name: "POSTS")
    //                    }
    //                }
    //                i+=1
    //            }
    //
    //            self.modelSql.setLastUpdate(name: "POSTS", lastUpdated: lud)
    //            let finalData = self.modelSql.getAllPosts()
    //            //self.modelSql.getNumOfPosts()
    //
    //            callback(finalData)
    //        }
    //        //  modelFirebase.getAllPosts(callback: callback)
    //    }
    
    func getMyPosts(callback:@escaping ([Post]?)->Void){
        
        modelFirebase.getMyPosts(callback: callback)
    }
    
    func deleteMyPost(postID:String){
        modelFirebase.deleteMyPost(postID: postID)
        modelSql.delete(postId: postID)
    }
    
    func updateMyPost(postId:String, post:Post){
        modelFirebase.updateMyPost(postId: postId, post: post)
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

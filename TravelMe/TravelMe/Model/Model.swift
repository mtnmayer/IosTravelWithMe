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
    
    let weatherDataModel = WeatherDataModel()
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
        
        //get the cloud updates since the local update date
        modelFirebase.getAllPosts(since:lud) { (data) in
            //insert update to the local db
           // var lud:Int64 = 0;
            for post in data!{
                
                if post.lastUpdate! > lud {
                    lud = post.lastUpdate!
                    self.modelSql.addPost(post: post)
                }
            }
            //update the posts local last update date
            self.modelSql.setLastUpdate(name: "POSTS", lastUpdated: lud)
            
            
            // get the complete student list
            let finalData = self.modelSql.getAllPosts()
            callback(finalData);
        }
    }
    
    
    func getMyPosts(callback:@escaping ([Post]?)->Void){
        
        modelFirebase.getMyPosts(callback: callback)
    }
    
    func getFavoritePosts(callback:@escaping ([Post]?)->Void){
        
       // let data = modelSql.getFavoritePosts()
         modelFirebase.getFavoritePosts(callback: callback)
        //callback(data)
        
    }
    
    func deleteMyPost(postID:String){
        modelFirebase.deleteMyPost(postID: postID)
        modelSql.delete(postId: postID)
        modelFirebase.deleteFavoritePost(postID: postID)
    }
    
    func deleteFavoritePost(post:Post){
        //modelFirebase.deleteFavoritePost(postID: postID)
        post.setPostselected(postSelected: "false")
        //modelSql.addPost(post: post)
        modelFirebase.deleteFavoritePost(postID: post.postId!);
    }
    
    func deleteFavoritePostByID(postId:String){
        modelFirebase.deleteFavoritePost(postID: postId);
    }
    
    func updateMyPost(postId:String, post:Post){
        modelFirebase.updateMyPost(postId: postId, post: post)
    }
    
    func addFavoritePost(post:Post){
       // modelFirebase.addFavoritePost(post: post)
        post.setPostselected(postSelected: "true")
       // modelSql.addPost(post: post)
        modelFirebase.addFavoritePost(post: post);
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

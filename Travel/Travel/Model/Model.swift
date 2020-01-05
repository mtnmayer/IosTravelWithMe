//
//  Model.swift
//  Travel
//
//  Created by admin on 04/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Model{
    
    static let instance = Model()
    
    var modelFirebase:ModelFirebase = ModelFirebase()
    var data = [Post]()
    
    private init(){
        for i in 0...5{
            let post = Post(title: String(i), place: String(i), description: String(i), avatar: "")
            addPost(post: post)
        }
    }
    
    func addPost(post:Post){
        data.append(post)
    }
    
    func getAllPosts()->[Post]{
        
        return data
    }
    
    func CreateUser(user:User){
        
        modelFirebase.createUser(email: user.email, password: user.password)
        
        
    }
    
}

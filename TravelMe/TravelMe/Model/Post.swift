//
//  Post.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase

class Post{
    
    var title:String = ""
    var place: String = ""
    var description:String = ""
    var avatar:String = ""
    var lastUpdate: Int64?
    var email:String = ""
    var postId:String?
    static var postID:String?
    static var userEmail:String = ""
    static var numberOfPosts:Int = 0
    
    init(title:String,place:String, description:String, avatar:String, email:String) {
        self.title = title
        self.description = description
        self.avatar = avatar
        self.place = place
        self.email = email
        //self.postId = postId
    }
    
    init(json:[String:Any]){
        self.title = json["title"] as! String;
        self.place = json["place"] as! String;
        self.description = json["description"] as! String
        self.avatar = json["avatar"] as! String;
        self.email = Post.userEmail
        self.postId = Post.postID
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["title"] = title
        json["place"] = place
        json["description"] = description
        json["avatar"] = avatar
        json["email"] = email
        json["postId"] = postId
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
    func setPostId(postID:String){
        self.postId = postID
    }
}

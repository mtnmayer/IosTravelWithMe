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
    var postSelected:String = "false"
    static var postID:String?
    static var userEmail:String = ""
    static var numberOfPosts:Int = 0
    static var postSet:Set = Set<String>()
    static var favoritePostSet:Set = Set<String>()
    static var arrOfPost = [Post]()
    
    init(title:String,place:String, description:String, avatar:String, email:String, postId: String, postSelected:String) {
        self.title = title
        self.description = description
        self.avatar = avatar
        self.place = place
        self.email = email
        //Post.userEmail = email
        self.postId = postId
        self.postSelected = postSelected
    }
    
    init(json:[String:Any]){
        self.title = json["title"] as! String;
        self.place = json["place"] as! String;
        self.description = json["description"] as! String
        self.avatar = json["avatar"] as! String;
        self.email = json["email"] as! String
        self.postId = Post.postID
        self.postSelected = json["postSelected"] as! String
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
        json["postSelected"] = postSelected
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
    func setPostselected(postSelected:String){
        self.postSelected = postSelected
    }
    
    func favoriteToJson() -> [String:Any] {
          var json = [String:Any]();
          json["title"] = title
          json["place"] = place
          json["description"] = description
          json["avatar"] = avatar
          json["email"] = email
          json["postId"] = postId
          json["postSelected"] = postSelected
          json["lastUpdate"] = FieldValue.serverTimestamp()
        
          return json;
      }
}

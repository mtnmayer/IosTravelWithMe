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
    var userEmail:String = ""
    
    init(title:String,place:String, description:String, avatar:String) {
        self.title = title
        self.description = description
        self.avatar = avatar
        self.place = place
    }
    
    init(json:[String:Any]){
        self.title = json["title"] as! String;
        self.place = json["place"] as! String;
        self.description = json["description"] as! String
        self.avatar = json["avatar"] as! String;
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["title"] = title
        json["place"] = place
        json["description"] = description
        json["avatar"] = avatar
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}

//
//  Post.swift
//  Travel
//
//  Created by admin on 04/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Post{
    
    var title:String = ""
    var place: String = ""
    var description:String = ""
    var avatar:String = ""
    
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
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["title"] = title
        json["place"] = place
        json["description"] = description
        json["avatar"] = avatar
        return json;
    }
    
}

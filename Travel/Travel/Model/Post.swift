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
    var description: String = ""
    var avatar:String = ""
    
    init(title:String, description:String, avatar:String) {
        self.title = title
        self.description = description
        self.avatar = avatar
    }
    
}

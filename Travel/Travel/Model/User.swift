//
//  User.swift
//  Travel
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class User{
    
    var email:String = ""
    var password:String = ""
    
    init(email:String, pass:String){
        self.email = email
        self.password = pass
    }
}

//
//  EventNotificationBaseWithArgs.swift
//  Travel
//
//  Created by admin on 11/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation


class EventNotificationBaseWithObj<T>{
    
    let eventName:String
    
    init(eventName:String){
        self.eventName = eventName
    }
    
    func observ(callback:@escaping(T)->Void){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                let d_data:T = data.userInfo!["data"] as! T
                                                callback(d_data)
        }
    }
    
    func post(data:T){
        
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: ["data": data])
    }
}

//
//  EventNotification.swift
//  Travel
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class EventNotificationBase{
    
    let eventName:String
    
    init(eventName:String){
        self.eventName = eventName
    }
    
    func observ(callback:@escaping()->Void){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
        object: nil, queue: nil) { (data) in
            callback()
         }
    }
    
    func post(){
           
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
        object: self,
        userInfo: nil)
    }
}

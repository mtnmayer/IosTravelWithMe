//
//  ModelEvents.swift
//  Travel
//
//  Created by admin on 07/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class ModelEvents{
    
    static let postDataEvent = EventNotificationBase(eventName: "postDataEvent")
    static let gpsUpdateEvent = EventNotificationBaseWithObj<String>(eventName: "GPSUpdateEvent")
    
    private init(){
        
    }
}

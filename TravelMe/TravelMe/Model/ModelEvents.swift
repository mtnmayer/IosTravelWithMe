//
//  ModelEvents.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


class ModelEvents{
    
    static let postDataEvent = EventNotificationBase(eventName: "postDataEvent")
    static let gpsUpdateEvent = EventNotificationBaseWithObj<String>(eventName: "GPSUpdateEvent")
    
    private init(){
        
    }
}

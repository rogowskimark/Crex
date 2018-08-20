//
//  Crex.swift
//  Crex
//
//  Created by Marek Rogowski on 19.08.2018.
//  Copyright © 2018 Marek Rogowski. All rights reserved.
//

import Foundation

open class Crex<T: CrexEvent> {
    
    public static func addObserver(notificationCenter: NotificationCenter = .default, object: Any? = nil, queue: OperationQueue? = nil, handler: @escaping ((Notification, T.PayloadType?) -> Void)) {
        let handler: ((Notification) -> (Void)) = { notification in
            
            guard let userInfo = notification.userInfo else {
                handler(notification, nil)
                return
            }
            
            if let payload = userInfo["payloadKey"] as? T.PayloadType {
                handler(notification, payload)
            } else if let transformation = T.transformation {
                handler(notification, transformation(userInfo))
            }
        }
        
        notificationCenter.addObserver(forName: T.notificationName,
                                       object: object,
                                       queue: queue,
                                       using: handler)
    }
    
    public static func post(notificationCenter: NotificationCenter = .default, object: Any? = nil, _ payload: T.PayloadType) {
        notificationCenter.post(name: T.notificationName, object: object, userInfo: ["payloadKey": payload])
    }
    
    public static func post(notificationCenter: NotificationCenter = .default, object: Any? = nil) {
        notificationCenter.post(name: T.notificationName, object: object, userInfo: nil)
    }
    
}

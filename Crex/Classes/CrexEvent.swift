//
//  CrexEvent.swift
//  NotificationBlock
//
//  Created by Marek Rogowski on 20.08.2018.
//  Copyright © 2018 Marek Rogowski. All rights reserved.
//

import Foundation

public protocol CrexEvent {
    associatedtype PayloadType
    
    typealias CrexUserInfo = [AnyHashable: Any]
    typealias CrexTransformation = ((CrexUserInfo) -> PayloadType?)?
    
    static var notificationName: NSNotification.Name { get }
    static var transformation: CrexTransformation { get }
}

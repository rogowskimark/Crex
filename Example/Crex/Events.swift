//
//  Events.swift
//  Crex_Example
//
//  Created by Marek Rogowski on 20.08.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Crex

struct Events {
    
    struct QueueStateChanged: CrexEvent {
        
        typealias PayloadType = QueueStateChanged.Payload
        static let notificationName = NSNotification.Name(rawValue: "MyApp.QueueStateChanged")
        static let transformation: CrexTransformation = nil
        
        struct Payload {
            let updatedAt = Date()
            let itemsLeft: Int
        }
    }
    
    struct QueueDidFinish: CrexEvent {
        typealias PayloadType = Void
        static let notificationName = NSNotification.Name(rawValue: "MyApp.QueueDidFinish")
        
        static let transformation: CrexTransformation = nil
    }
    
    struct Application {
        
        struct DidBecomeActive: CrexEvent {
            typealias PayloadType = Void
            static let notificationName: NSNotification.Name = .UIApplicationDidBecomeActive
            static let transformation: CrexTransformation = nil
        }
        
    }
    
    struct UI {
        
        struct KeyboardWillShow: CrexEvent {
            typealias PayloadType = KeyboardWillShow.KeyboardPayload
            static let notificationName: NSNotification.Name = .UIKeyboardWillShow
            
            static let transformation: CrexTransformation = { (userInfo: CrexUserInfo) in
                guard let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
                    let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                        return nil
                }
                return KeyboardPayload(height: keyboardSize.height, animationDuration: animationDuration)
            }
            
            struct KeyboardPayload {
                let height: CGFloat
                let animationDuration: TimeInterval
            }
        }

    }
    
}

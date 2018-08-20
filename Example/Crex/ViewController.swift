//
//  ViewController.swift
//  Crex
//
//  Created by rogowskimark on 08/20/2018.
//  Copyright (c) 2018 rogowskimark. All rights reserved.
//

import UIKit
import Crex

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Crex<Events.QueueStateChanged>.addObserver { (_, queueState) in
            guard let queueState = queueState else {
                return
            }
            
            print("Queue updated: \(queueState.updatedAt), items left: \(queueState.itemsLeft)")
        }
        
        Crex<Events.QueueDidFinish>.addObserver { (_, _) in
            print("Queue did finish")
        }
        
        Crex<Events.Application.DidBecomeActive>.addObserver { (_, _) in
            print("Application did become active")
        }
        
        Crex<Events.UI.KeyboardWillShow>.addObserver { (_, keyboard) in
            guard let keyboard = keyboard else {
                return
            }
            
            print("Will show keyboard height: \(keyboard.height), duration: \(keyboard.animationDuration)")
        }
        
    }

    @IBAction func postQueueStateChanged(_ sender: Any) {
        Crex<Events.QueueStateChanged>.post(Events.QueueStateChanged.Payload(itemsLeft: 42))
    }
    
    @IBAction func postQueueDidFinish(_ sender: Any) {
        Crex<Events.QueueDidFinish>.post()
    }
    
    @IBAction func showKeyboard(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
}


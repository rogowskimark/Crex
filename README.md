
# Crex



[![CI Status](https://img.shields.io/travis/rogowskimark/Crex.svg?style=flat)](https://travis-ci.org/rogowskimark/Crex)

[![Version](https://img.shields.io/cocoapods/v/Crex.svg?style=flat)](https://cocoapods.org/pods/Crex)

[![License](https://img.shields.io/cocoapods/l/Crex.svg?style=flat)](https://cocoapods.org/pods/Crex)

[![Platform](https://img.shields.io/cocoapods/p/Crex.svg?style=flat)](https://cocoapods.org/pods/Crex)





Crex is an library for simple and type safe usage of Notification Center. Posting extra information is so handy due to code completion.



## Example



To run the example project, clone the repo, and run `pod install` from the Example directory first.



## Requirements



- iOS 9.3+

- Swift 4.1



## Installation



Crex is available through [CocoaPods](https://cocoapods.org). To install

it, simply add the following line to your Podfile:



```ruby

pod 'Crex'

```



## Usage



### Definig Event


```swift 
import Crex

struct QueueStateChanged: CrexEvent {

    typealias PayloadType = QueueStateChanged.Payload
    static let notificationName = NSNotification.Name(rawValue: "MyApp.QueueStateChanged")
    static let transformation: CrexTransformation = nil

    struct Payload {
        let updatedAt = Date()
        let itemsLeft: Int
    }
}
```


### Registering observer


```swift
Crex<QueueStateChanged>.addObserver { (_, queueState) in
    guard let queueState = queueState else {
        return
    }

    print("Queue updated: \(queueState.updatedAt), items left: \(queueState.itemsLeft)")
}
```

### Posting event

```swift
Crex<QueueStateChanged>.post(QueueStateChanged.Payload(itemsLeft: 42))
```

### Using system notifications

```swift
struct ApplicationDidBecomeActive: CrexEvent {
    typealias PayloadType = Void
    static let notificationName: NSNotification.Name = .UIApplicationDidBecomeActive
    static let transformation: CrexTransformation = nil
}

Crex<ApplicationDidBecomeActive>.addObserver { (_, _) in
    print("Application did become active")
}
```


### Using transformation

Sometimes it is enough to just take some bits of data passed iside notification sent from system. Also in this approach we are not creating duplication when fetching data from userInfo dictionary.

```swift
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

Crex<KeyboardWillShow>.addObserver { (_, keyboard) in
    guard let keyboard = keyboard else {
        return
    }

    print("Will show keyboard height: \(keyboard.height), duration: \(keyboard.animationDuration)")
}
```

## Author



Marek Rogowski, rogowski.mark@gmail.com



## License



Crex is available under the MIT license. See the LICENSE file for more info.

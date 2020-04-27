//
//  UserDefaultManager.swift
//  DotVet
//
//  Created by Jose Frometa on 4/27/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
  @UserDefault("phoneNumber", defaultValue: nil)
  static var phoneNumber: String?
    
  @UserDefault("appInitialEntry", defaultValue: false)
  static var appInitialEntry: Bool


  static func eraseAll() {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      UserDefaults.standard.synchronize()
    } else {
      NSLog("Was unable to erase UserDefaults data.")
    }
  }
}


@propertyWrapper
struct UserDefault<T> {
  let key: String
  let defaultValue: T

  init(_ key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }

  var wrappedValue: T {
    get {
      return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}

//
//  NavigableProtocol.swift
//  DotVet
//
//  Created by Jose Frometa on 5/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine

extension UIViewController: Navigable {}
protocol Navigable {
    var navbarThemeConfiguration: NavbarThemeConfiguration? { get }
    var rightButtonTap: PassthroughSubject<Void, Never> { get }
    var leftButtonTap: PassthroughSubject<Void, Never> { get }
}
extension Navigable {
    var navbarThemeConfiguration: NavbarThemeConfiguration? {
          nil
     }
      
     var rightButtonTap: PassthroughSubject<Void, Never> {
          PassthroughSubject<Void, Never>()
     }
      
      var leftButtonTap: PassthroughSubject<Void, Never> {
          PassthroughSubject<Void, Never>()
      }
}

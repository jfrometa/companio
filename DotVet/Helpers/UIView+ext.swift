//
//  UIView+ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine

protocol AutoLayable: UIView {
    func withAutoLayout() -> Self
}

extension UIView: AutoLayable {
    func withAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIView {
   func assign<Value>(
       _ publisher: AnyPublisher<Value, Never>,
       to key: ReferenceWritableKeyPath<UIView, Value>
   ) -> AnyCancellable {
       return publisher.assign(to: key, on: self)
   }
}

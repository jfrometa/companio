//
//  UIBarButtonItem+Combine_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 5/4/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

/// from repo -> https://github.com/emoncms/emoncms-ios/blob/master/EmonCMSiOS/Helpers/Rx/UIControl%2BCombine.swift

import UIKit
import Combine

final class UIBarButtonItemSubscription<SubscriberType: Subscriber>: Subscription
  where SubscriberType.Input == UIBarButtonItem {
  private var subscriber: SubscriberType?
  private let control: UIBarButtonItem

  init(subscriber: SubscriberType, control: UIBarButtonItem) {
    self.subscriber = subscriber
    self.control = control
    control.target = self
    control.action = #selector(self.eventHandler)
  }

  func request(_ demand: Subscribers.Demand) {
    // We do nothing here as we only want to send events when they occur.
    // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
  }

  func cancel() {
    self.subscriber = nil
  }

  @objc private func eventHandler() {
    _ = self.subscriber?.receive(self.control)
  }
}

struct UIBarButtonItemPublisher: Publisher {
  typealias Output = UIBarButtonItem
  typealias Failure = Never

  let control: UIBarButtonItem

  init(control: UIBarButtonItem) {
    self.control = control
  }

  func receive<S>(subscriber: S) where S: Subscriber, S.Failure == UIBarButtonItemPublisher.Failure,
    S.Input == UIBarButtonItemPublisher.Output {
    let subscription = UIBarButtonItemSubscription(subscriber: subscriber, control: control)
    subscriber.receive(subscription: subscription)
  }
}

extension UIBarButtonItem {
  func publisher() -> UIBarButtonItemPublisher {
    return UIBarButtonItemPublisher(control: self)
  }
}

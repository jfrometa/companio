//
//  NavBarThemeconfiguration.swift
//  DotVet
//
//  Created by Jose Frometa on 5/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

struct NavbarThemeConfiguration {
  var navigationBarStyle: NavigationControllerStyle
  var title: String?
  var tintColor: UIColor
  var barColor: UIColor
  var rightBtnAction: (() -> Void)?

  init(style navigationBarStyle: NavigationControllerStyle = .titleOnly,
       title: String? = nil,
       tintColor: UIColor = .black,
       barColor: UIColor = .white) {
    self.navigationBarStyle = navigationBarStyle
    self.title = title
    self.tintColor = tintColor
    self.barColor = barColor
  }
}


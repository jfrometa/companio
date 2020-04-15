//
//  String_UIKit_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

extension String {
  func formatTextWithFont(size: CGFloat = 16, color: UIColor = .black) -> NSMutableAttributedString {
      return NSMutableAttributedString(string: self, attributes: [
        .font:  UIFont.systemFont(ofSize: size),
        .foregroundColor: color,
      ])
  }
}

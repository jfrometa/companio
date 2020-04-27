//
//  FormTableViewHeaderView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

class FormTableViewHeaderView: UIView {
  private let title = UILabel().withAutoLayout()
  private let subtitle = UILabel().withAutoLayout()
    
  init(frame: CGRect = .init(x: 0, y: 0,
                           width: UIScreen.main.bounds.width,
                           height: 90), data: TitleAndMessage) {
        
    super.init(frame: frame)
    self.setView(data: data)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  private func setView(data: TitleAndMessage) {
    self.title.numberOfLines = 0
    self.title.lineBreakMode = .byWordWrapping
    self.title.attributedText = data.title.formatTextWithFont()
    self.title.textAlignment = .center

    self.subtitle.numberOfLines = 0
    self.subtitle.lineBreakMode = .byWordWrapping
    self.subtitle.attributedText = data.message.formatTextWithFont()
    self.subtitle.textAlignment = .center

    self.addSubview(title)
    self.addSubview(subtitle)
    self.backgroundColor = .clear
    
    self.title
    .constrain(top: safeTopAnchor,
        leading: safeLeadingAnchor,
        trailing: safeTrailingAnchor,
        padding: .init(top: 8, left: 38, bottom: 0, right: 38))

    self.subtitle
        .constrain(top: title.safeTopAnchor,
        leading: safeLeadingAnchor,
        bottom: safeBottomAnchor,
        trailing: safeTrailingAnchor,
        padding: .init(top: 8, left: 38, bottom: 20, right: 38))
    
//    constrain(self.title, self.subtitle) { title, subtitle in
//       guard let sv = title.superview else { return }
//       sv.height >= frame.height
//       sv.width == frame.width
//            
//       title.top == sv.top + 8
//       title.leading == sv.leading + 38
//       title.trailing == sv.trailing - 37
//
//       subtitle.top == title.bottom + 8
//       subtitle.leading == sv.leading + 38
//       subtitle.trailing == sv.trailing - 37
//       subtitle.bottom == sv.bottom - 20
//      }
//    }
  }
}

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
        setView(data: data)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setView(data: TitleAndMessage) {
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.attributedText = data.title.formatTextWithFont()
        title.textAlignment = .center

        subtitle.numberOfLines = 0
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.attributedText = data.message.formatTextWithFont()
        subtitle.textAlignment = .center

        addSubview(title)
        addSubview(subtitle)
        backgroundColor = .clear

        title
            .constrain(top: safeTopAnchor,
                       leading: safeLeadingAnchor,
                       trailing: safeTrailingAnchor,
                       padding: .init(top: 8, left: 38, bottom: 0, right: 38))

        subtitle
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

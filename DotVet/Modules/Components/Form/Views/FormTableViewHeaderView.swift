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
    private let container = UIView().withAutoLayout()
    
    init(frame: CGRect = .zero, data: TitleAndMessage) {
        super.init(frame: frame)
        self.setView(data: data)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setView(data: TitleAndMessage) {
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        self.title.attributedText = data.title.formatTextWithFont(size: 20, color: .black)
        self.title.textAlignment = .center

        self.subtitle.numberOfLines = 0
        self.subtitle.lineBreakMode = .byWordWrapping
        self.subtitle.attributedText = data.message.formatTextWithFont(size: 14,color: .gray)
        self.subtitle.textAlignment = .center

        self.container.addSubview(self.title)
        self.container.addSubview(self.subtitle)
        self.addSubview(self.container)
        self.backgroundColor = .clear
        
        self.title
            .constrain(top: topAnchor,
                      leading:leadingAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 8, left: 38, bottom: 0, right: 38))

        self.subtitle
            .constrain(top: self.title.bottomAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing:trailingAnchor,
                      padding: .init(top: 8, left: 38, bottom: 10, right: 38))

        self.container
            .constrain(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor)
    }
}

//
//  NSContraintsLayout_Ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.topAnchor }
    var safeBottomAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.bottomAnchor }
    var safeLeadingAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.leadingAnchor }
    var safeTrailingAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.trailingAnchor }

    func constrain(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil,
                   bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,
                   centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil,
                   padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        if let _top = top {
            topAnchor.constraint(equalTo: _top, constant: padding.top).isActive = true
        }
        if let _leading = leading {
            leadingAnchor.constraint(equalTo: _leading, constant: padding.left).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }

        if let _bottom = bottom {
            bottomAnchor.constraint(equalTo: _bottom, constant: -padding.bottom).isActive = true
        }

        if let _trailing = trailing {
            trailingAnchor.constraint(equalTo: _trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

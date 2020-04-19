//
//  MDCTextField_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/19/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents

extension MDCTextField {
    func standar() {
      keyboardType = .default
      returnKeyType = .done
      clearsOnBeginEditing = false
      clearsOnInsertion = false
      textColor = .black
      attributedPlaceholder = "Place Holder".formatTextWithFont(size: 16, color: .darkGray)
      attributedText = "Full Name".formatTextWithFont(size: 16, color: .darkGray)
    }
}

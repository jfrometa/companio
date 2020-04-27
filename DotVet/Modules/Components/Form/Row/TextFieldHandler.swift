//
//  TextFieldHandler.swift
//  DotVet
//
//  Created by Jose Frometa on 4/27/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol TextFieldHandler: UITextFieldDelegate {
    var hidesPlaceholderOnInput: Bool { get set }
    var returnKeyType: UIReturnKeyType { get set }
    var isValidInput: () -> Bool { get }
    var viewModel: TextFieldCellViewModel? { get }
}

extension TextFieldCellView: TextFieldHandler {
    var isValidInput: () -> Bool {
        { true }
    }

    var hidesPlaceholderOnInput: Bool {
        get { textfield.hidesPlaceholderOnInput }
        set { textfield.hidesPlaceholderOnInput = newValue }
    }

    var returnKeyType: UIReturnKeyType {
        get { textfield.returnKeyType }
        set { textfield.returnKeyType = newValue }
    }
}

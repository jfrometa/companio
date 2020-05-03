//
//  TextFieldHandler.swift
//  DotVet
//
//  Created by Jose Frometa on 4/27/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol TextFieldHandler: UITextFieldDelegate {
    var returnKeyType: UIReturnKeyType { get set }
    var viewModel: TextFieldCellViewModel? { get }
}

extension TextFieldCellView: TextFieldHandler {
    var returnKeyType: UIReturnKeyType {
        get { textfield.returnKeyType }
        set { textfield.returnKeyType = newValue }
    }
}

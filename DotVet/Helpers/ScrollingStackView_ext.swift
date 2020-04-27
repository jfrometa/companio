//
//  ScrollingStackView_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/18/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import UIKit
import MaterialComponents

protocol AdjustableForKeyboard: class {
    func subscribeToKeyboard(store: inout Set<AnyCancellable>)
}

protocol FieldConnectable: AdjustableForKeyboard {
    func connectTextFields()
}

extension TextFieldCellView {
    class func connectNextKeyboardReturnKey(for fields: [TextFieldCellView]) {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].textfield
                .addTarget(fields[i + 1],
                           action: #selector(UIResponder.becomeFirstResponder),
                           for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.textfield.addTarget(last,
                               action: #selector(UIResponder.resignFirstResponder),
                               for: .editingDidEndOnExit)
    }
}

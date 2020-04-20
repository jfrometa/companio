//
//  ScrollingStackView_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/18/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import UIKit

protocol AdjustableForKeyboard: class {
    func subscribeToKeyboard(store: inout Set<AnyCancellable>)
}

protocol FieldConnectable: AdjustableForKeyboard {
    func connectTextFields()
}

extension ScrollingStackView: FieldConnectable {
    func subscribeToKeyboard(store: inout Set<AnyCancellable>) {
        let keyboardWillOpen = NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            //  .map {$0.height}
            .map { [unowned self] in self.convert($0, from: self.window) }
            .map { [unowned self] in $0.height - self.safeAreaInsets.bottom }
            .print()

        let keyboardWillHide = NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return Publishers
            .Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \UIScrollView.contentInset.bottom, on: self)
            .store(in: &store)
    }

    func connectTextFields() {
        let textFields = arrangedSubviews.compactMap { $0 as? UITextField }
        UITextField.connectNextKeyboardReturnKey(for: textFields)
    }
}

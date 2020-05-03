//
//  MDCTextField_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/19/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import IQKeyboardManagerSwift
import MaterialComponents

extension MDCTextField {
    var textDidChangeNotification: AnyPublisher<String, Never> {
        return NotificationCenter
            .default
            .publisher(for: MDCTextField.textDidChangeNotification, object: self)
            .map { $0.object as? MDCTextField }
            .compactMap { $0?.text }
            .eraseToAnyPublisher()
    }

    func maxInput(chars: Int, store: inout Set<AnyCancellable>) {
        textDidChangeNotification
            .map { ($0.count > chars) ? String($0.prefix(chars)) : $0 }
            .eraseToAnyPublisher()
            .assign(to: \.text, on: self)
            .store(in: &store)
    }

    func validateInput(controller: MDCTextInputControllerBase,
                       model: TextFieldCellViewModel,
                       store: inout Set<AnyCancellable>,
                       validate: ((String) -> Bool)?) {
        textDidChangeNotification
            .map { text -> Bool in
                guard let _validate = validate else { return true }
                return _validate(text)
             }
            .sink(receiveValue: { isValid in
                if !isValid {
                    model.validationPublisher.send(false)
                    controller.setErrorText("errorMessage", errorAccessibilityValue: nil) }
                else {
                    model.validationPublisher.send(true)
                    controller.setErrorText(nil, errorAccessibilityValue: nil)
                }
            })
            .store(in: &store)
    }

    func hasNext(store: inout Set<AnyCancellable>) {
        publisher(for: [.editingDidEndOnExit])
            .sink(receiveValue: { _ in
                IQKeyboardManager.shared.goNext()
            })
            .store(in: &store)
    }

    func standar(_ color: UIColor = .black) {
        keyboardType = .default
        returnKeyType = .done
        clearsOnBeginEditing = false
        clearsOnInsertion = false
        textColor = color
    }
}

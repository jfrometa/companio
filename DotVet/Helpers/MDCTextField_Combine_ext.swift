//
//  MDCTextField_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/19/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
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
                       errorMessage: String,
                       store: inout Set<AnyCancellable>,
                       scan: @escaping (String) -> Bool) {
        textDidChangeNotification
            .map { scan($0) }
            .sink(receiveValue: { isValid in
                if !isValid { controller.setErrorText(errorMessage, errorAccessibilityValue: nil) }
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

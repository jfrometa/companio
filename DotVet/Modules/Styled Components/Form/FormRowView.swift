//
//  FormCellView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import MaterialComponents
import UIKit
import UserNotifications

protocol TextFieldHandler: UITextFieldDelegate {
    var hidesPlaceholderOnInput: Bool { get set }
    var returnKeyType: UIReturnKeyType { get set }
    var isValidInput: () -> Bool { get }
}

extension FormRowView: TextFieldHandler {
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

class FormRowView: UIView {
    private var cancelableBag = Set<AnyCancellable>()
    private var tfController: MDCTextInputControllerUnderline
    private let textfield: MDCTextField = {
        let tf = MDCTextField().withAutoLayout()
        tf.standar()
        return tf
    }()

    init(viewModel _: FormViewModel? = nil) {
        tfController = MDCTextInputControllerUnderline(textInput: textfield)
        super.init(frame: .zero)
        setView()
        setContraints()
        subscribeEvents()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        tfController.start(textfield, placeHolder: "UN PLACEHOLDER")
        textfield.maxInput(chars: 5, store: &cancelableBag)
        addSubview(textfield)
    }

    private func setContraints() {
        textfield.constrain(top: safeTopAnchor,
                            leading: safeLeadingAnchor,
                            bottom: safeBottomAnchor,
                            trailing: safeTrailingAnchor,
                            padding: .init(top: 0, left: 10, bottom: -15, right: 0))
    }

    private func subscribeEvents() {}
}

extension FormRowView {
    func createCell() {}
}

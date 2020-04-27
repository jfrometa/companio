//
//  FormCellView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents
import UIKit

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
    private var tfController: MDCTextInputControllerUnderline?
    private let textfield: MDCTextField = {
        let tf = MDCTextField().withAutoLayout()
        tf.standar()
        tf.borderWidth = 1
        tf.borderColor = .red
        return tf
    }()

    override init(frame: CGRect) {
        tfController = MDCTextInputControllerUnderline(textInput: textfield)
        super.init(frame: frame)
        tfController?.start(textfield, placeHolder: "UN PLACEHOLDER", placeHolderImage: "")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        addSubview(textfield)
    }

    private func setContraints() {
        textfield.constrain(top: safeTopAnchor,
                            leading: safeLeadingAnchor,
                            bottom: safeBottomAnchor,
                            trailing: safeTrailingAnchor,
                            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
}

extension FormRowView {
    func createCell() {}
}

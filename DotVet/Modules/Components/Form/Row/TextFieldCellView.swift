//
//  FormCellView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import IQKeyboardManagerSwift
import MaterialComponents
import UIKit
import UserNotifications

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

class TextFieldCellView: UITableViewCell {
    var viewModel: TextFieldCellViewModel?
    private var cancelableBag = Set<AnyCancellable>()

    var tfController: MDCTextInputControllerUnderline
    let textfield: MDCTextField = {
        let tf = MDCTextField().withAutoLayout()
        tf.standar()
        tf.keyboardType = .default
        tf.returnKeyType = .next
        tf.clearsOnBeginEditing = false
        tf.clearsOnInsertion = false
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        tfController = MDCTextInputControllerUnderline(textInput: textfield)
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setView()
        setContraints()
        subscribeEvents()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        addSubview(textfield)
    }

    private func setContraints() {
        textfield
            .constrain(top: safeTopAnchor,
                       leading: safeLeadingAnchor,
                       bottom: safeBottomAnchor,
                       trailing: safeTrailingAnchor,
                       padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }

    private func subscribeEvents() {
        textfield
            .publisher(for: [.editingDidEnd, .editingDidEndOnExit])
            .combineLatest(textfield.textDidChangeNotification)
            .sink(receiveValue: { _, text in
                print("text: \(text)")
            })
            .store(in: &cancelableBag)
    }
}

extension TextFieldCellView {
    private func dismissKeyboard() {
        DispatchQueue.main.async {
            guard IQKeyboardManager.shared.keyboardShowing else { return }
            IQKeyboardManager.shared.goPrevious()
            IQKeyboardManager.shared.resignFirstResponder()
            IQKeyboardManager.shared.goNext()
        }
    }

    func bind(viewModel: TextFieldCellViewModel) {
        self.viewModel = viewModel
        tfController.start(textfield, placeHolder: viewModel.placeHolder)

        switch viewModel.fieldType {
        case .datePicker:
            textfield.setDatePickerAsTextInput()
        default:
            textfield
                .validateInput(controller: tfController,
                               errorMessage: "errorMessage",
                               store: &cancelableBag,
                               validate: viewModel.validation)
            textfield.hasNext(store: &cancelableBag)
        }

        if let max = viewModel.maxInput {
            textfield.maxInput(chars: max, store: &cancelableBag)
        }

        if let underline = viewModel.underlineMessage {
            textfield.leadingUnderlineLabel.text = underline
        }

        if let defaultValue = viewModel.defaultValue {
            textfield.text = defaultValue
        }
    }
}

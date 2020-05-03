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

class TextFieldCellView: UITableViewCell {
    var viewModel: TextFieldCellViewModel? = nil
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
        self.tfController = MDCTextInputControllerUnderline(textInput: textfield)
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setView()
        self.setContraints()
        self.subscribeEvents()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        self.addSubview(textfield)
    }

    private func setContraints() {
        self.textfield
            .constrain(top: safeTopAnchor,
                   leading: safeLeadingAnchor,
                   bottom: safeBottomAnchor,
                   trailing: safeTrailingAnchor,
                   padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }

    private func subscribeEvents() {
        self.textfield
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
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
        self.tfController.start(textfield, placeHolder: viewModel.placeHolder)
        
        switch viewModel.fieldType {
        case .datePicker:
            self.textfield.setDatePickerAsTextInput()
        default:
            self.textfield
                .validateInput(controller: tfController,
                               model: viewModel,
                               store: &cancelableBag,
                               validate: viewModel.validation)
        }
        
        self.textfield.hasNext(store: &cancelableBag)

        if let max = viewModel.maxInput {
            self.textfield.maxInput(chars: max, store: &cancelableBag)
        }

        if let underline = viewModel.underlineMessage {
            self.textfield.leadingUnderlineLabel.text = underline
        }

        if let defaultValue = viewModel.defaultValue {
            self.textfield.text = defaultValue
        }
    }
}

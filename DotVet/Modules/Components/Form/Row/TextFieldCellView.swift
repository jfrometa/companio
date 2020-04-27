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
import IQKeyboardManagerSwift


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
                padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }

    private func subscribeEvents() {
      textfield
        .publisher(for: [.editingDidEnd, .editingDidEndOnExit])
        .combineLatest(textfield.textDidChangeNotification)
        .sink(receiveValue: { (_ , text) in
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
        self.tfController.start(self.textfield, placeHolder: viewModel.placeHolder)
        
        switch viewModel.fieldType {
        case .datePicker:
           self.textfield.setDatePickerAsTextInput()
        default:
           self.textfield
               .validateInput(controller: tfController,
                            errorMessage: "errorMessage",
                            store: &cancelableBag,
                            validate: viewModel.validation )
           self.textfield.hasNext(store: &cancelableBag)
        }
        
        if let max = viewModel.maxInput {
            self.textfield.maxInput(chars: max, store: &self.cancelableBag)
        }
        
        if let underline = viewModel.underlineMessage  {
            self.textfield.leadingUnderlineLabel.text = underline
        }
        
        if let defaultValue = viewModel.defaultValue  {
            self.textfield.text = defaultValue
        }
    
    }
}

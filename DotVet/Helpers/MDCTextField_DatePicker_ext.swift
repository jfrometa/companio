//
//  UITextView_DatePicker_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents
import UIKit
import Combine

protocol ToolBarable: UIView {
    func setDatePickerAsTextInput(controller: MDCTextInputControllerBase,
                                model: TextFieldCellViewModel,
                                store: inout Set<AnyCancellable>,
                                validate: ((String) -> Bool)?)
}

extension MDCTextField: ToolBarable {
    internal func setKeyboardToolBar(controller: MDCTextInputControllerBase,
                                  picker: UIDatePicker,
                                  model: TextFieldCellViewModel,
                                  store: inout Set<AnyCancellable>) -> UIView {
        
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIView(frame: CGRect(x: 0.0, y: 0.0,
                            width: screenWidth, height: 44.0))
                            .withAutoLayout()
        toolBar.backgroundColor = .white
        
        let cancel = UIButton(type: .system).withAutoLayout()
        cancel.setTitle("Cancel", for: .normal)
        
        let done = UIButton(type: .system).withAutoLayout()
        done.setTitle("Done", for: .normal)
        
        cancel.publisher(for: [.touchUpInside])
            .print("Cancel Touch")
            .sink(receiveValue: { [weak self] _ in
                if let inputText = self?.text, inputText.isEmpty {
                    model.validationPublisher.send(false)
                    controller.setErrorText("errorMessage", errorAccessibilityValue: nil)
                }
                self?.resignFirstResponder()
            })
            .store(in: &store)
        
        done.publisher(for: [.touchUpInside])
            .print("Done Touch")
            .sink(receiveValue: { [weak self] _ in
            
                let dateformatter = DateFormatter()
                dateformatter.dateStyle = .medium
                let text = dateformatter.string(from: picker.date)
                self?.text = text
                
                guard let validation = model.validation else {
                    model.validationPublisher.send(true)
                    return
                }
                
                let isValid = validation(text)
                
                if !isValid {
                    model.validationPublisher.send(false)
                    controller.setErrorText("errorMessage", errorAccessibilityValue: nil) }
                else {
                    model.validationPublisher.send(true)
                    controller.setErrorText(nil, errorAccessibilityValue: nil)
                }
                
                self?.resignFirstResponder()
            })
            .store(in: &store)
        
        toolBar.addSubview(cancel)
        toolBar.addSubview(done)
        
        cancel.constrain(top: toolBar.topAnchor,
                         leading: toolBar.leadingAnchor,
                         bottom: toolBar.bottomAnchor,
                         padding: .init(top: 0, left: 8, bottom: 0, right: 0),
                         size: .init(width: 0, height: 44))
        
        done.constrain(top: toolBar.topAnchor,
                        bottom: toolBar.bottomAnchor,
                        trailing: toolBar.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 8),
                        size: .init(width: 0, height: 44))
        
        return toolBar
    }

    func setDatePickerAsTextInput(controller: MDCTextInputControllerBase,
                                model: TextFieldCellViewModel,
                                store: inout Set<AnyCancellable>,
                                validate: ((String) -> Bool)?) {
        
        let datePicker = UIDatePicker().withAutoLayout()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let toolBar = self.setKeyboardToolBar(controller: controller,
                                       picker: datePicker,
                                       model: model,
                                       store: &store)
        
        let keyBoardInputView = UIView(frame: .init(x: 0, y: 0,
                                      width: UIScreen.main.bounds.width,
                                      height: datePicker.frame.height + 44))
        
        keyBoardInputView.addSubview(toolBar)
        keyBoardInputView.addSubview(datePicker)
        
        toolBar.constrain(top: keyBoardInputView.topAnchor,
                         leading: keyBoardInputView.leadingAnchor,
                         trailing: keyBoardInputView.trailingAnchor)
        
        datePicker.constrain(top: toolBar.bottomAnchor,
                            leading: toolBar.leadingAnchor,
                            bottom: keyBoardInputView.bottomAnchor,
                            trailing: toolBar.trailingAnchor)
        
        guard let defaultDate = dateFormatter.date(from: "2019-01-01") else { return }
        datePicker.date = defaultDate
        self.inputView = datePicker
        
        self.inputView = keyBoardInputView
        
        self.validateInput(controller: controller,
                    model: model,
                    store: &store,
                    validate: model.validation)
    }
}

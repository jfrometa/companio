//
//  UITextView_DatePicker_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents
import UIKit

protocol ToolBarable: UIView {
    func setKeyboardToolBar(target: Any)
    func setDatePickerAsTextInput()
    var tapCancel: Selector { get }
    var tapDone: Selector { get }
}

extension MDCTextField: ToolBarable {
    var tapCancel: Selector { #selector(cancel) }
    var tapDone: Selector { #selector(done) }

    func setKeyboardToolBar(target: Any) {
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: target, action: nil)

        let cancel = UIBarButtonItem(title: "Cancel",
                                     style: .plain,
                                     target: target,
                                     action: tapCancel)
        let barButton = UIBarButtonItem(title: "Done",
                                        style: .plain,
                                        target: target,
                                        action: tapDone)

        toolBar.setItems([cancel, flexible, barButton], animated: false)
        inputAccessoryView = toolBar
    }

    func setDatePickerAsTextInput() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        setKeyboardToolBar(target: self)

        guard let text = self.text, !text.isEmpty,
            let prevDate = dateFormatter.date(from: text)
        else {
            guard let defaultDate = dateFormatter.date(from: "2020-01-01") else { return }
            datePicker.date = defaultDate
            inputView = datePicker
            return
        }
        datePicker.date = prevDate
        inputView = datePicker
    }

    @objc fileprivate func cancel() {
        resignFirstResponder()
    }

    @objc fileprivate func done() {
        guard let datePicker = self.inputView as? UIDatePicker
        else { return }

        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        text = dateformatter.string(from: datePicker.date)

        resignFirstResponder()
    }
}

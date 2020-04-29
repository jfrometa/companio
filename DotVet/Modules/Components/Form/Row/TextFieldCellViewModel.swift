//
//  FormCellViewModel.swift
//  DotVet
//
//  Created by Jose Frometa on 4/19/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import Foundation

struct TextFieldCellViewModel {
    let title: String
    let underlineMessage: String?
    let placeHolder: String?
    var maxInput: Int?
    var validation: (String) -> (Bool)
    let fieldType: FieldType
    var defaultValue: String?
    let isValidInput = PassthroughSubject<Bool, Never>()

    init(title: String,
         defaultValue: String = "",
         placeHolder: String = "",
         underlineMessage: String? = nil,
         fieldType: FieldType = .regular,
         validation: @escaping ((String) -> Bool) = { _ in false },
         maxInput: Int? = nil) {
        
        self.title = title
        self.placeHolder = placeHolder
        self.maxInput = maxInput
        self.validation = validation
        self.fieldType = fieldType
        self.defaultValue = defaultValue
        self.underlineMessage = underlineMessage
    }
    
    static func Mocked() -> [TextFieldCellViewModel] {
        return [TextFieldCellViewModel(title: "PET",
                                      defaultValue: "",
                                      placeHolder: "Pet Name",
                                      underlineMessage: "",
                                      fieldType: .regular,
                                      validation: { (inputText) -> Bool in
                                        return inputText.isOnlyLetters && !inputText.isEmpty
                                      },
                                      maxInput: 30),
               TextFieldCellViewModel(title: "PET",
                                defaultValue: "",
                                placeHolder: "Gender",
                                underlineMessage: "",
                                fieldType: .regular,
                                validation: { (inputText) -> Bool in
                                  return inputText.isOnlyLetters && !inputText.isEmpty
                                },
                                maxInput: 30)]
    }
    static func Mocked2() -> TextFieldCellViewModel {
        return TextFieldCellViewModel(title: "TITLE",
                                      defaultValue: "defaultValue",
                                      placeHolder: "placeHolder",
                                      underlineMessage: "underline messagge",
                                      fieldType: .datePicker,
                                      validation: { (inputText) -> Bool in
                                          print("inputText: onValidationClosure  \(inputText)")
                                          return true
                                      },
                                      maxInput: 20)
    }
}

enum FieldType {
    case regular
    case datePicker
    case modal
}

//
//  FormViewModelProtocol.swift
//  DotVet
//
//  Created by Jose Frometa on 5/3/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine

 
struct FormInput {
    let btnAddTap: UIControlPublisher<UIControl>
}

struct FormOutput {
    let btnAddTapped: AnyPublisher<UIControl, Never>
    let isValid: AnyPublisher<Bool, Never>
    let data: AnyPublisher<[FormTextFieldSectionModel], Never>
}


protocol FormViewModelable:  class {
  typealias Input = FormInput
  typealias Output = FormOutput
    
  func transform(input: Input) -> Output
  func fields() -> [TextFieldCellViewModel]
}

extension FormViewModelable {
   internal func transformToTextFieldSections(_ textFieldModels: [TextFieldCellViewModel])
    -> [FormTextFieldSectionModel] {
      
    textFieldModels
        .map { $0.title }
        .unique()
        .map { title -> FormTextFieldSectionModel in
          let items = textFieldModels.filter { $0.title == title }
          return FormTextFieldSectionModel(header: title, items: items)
        }
    }
    
  internal func makeValidatorPublisher(with fields: [TextFieldCellViewModel])
    -> AnyPublisher<Bool, Never> {
   
    fields
      .filter {  $0.validation != nil }
      .map { $0.validationPublisher }
      .combineLatest
      .map { $0.allSatisfy { $0 == true } }
      .eraseToAnyPublisher()
  }
}

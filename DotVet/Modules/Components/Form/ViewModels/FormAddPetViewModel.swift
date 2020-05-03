//
//  PetViewModel.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import UIKit


protocol FormViewModelable: ViewModelType {
  func fields() -> [TextFieldCellViewModel]

}

extension FormViewModelable {
   internal func transformToTextFieldSections(_ textFieldModels: [TextFieldCellViewModel]) -> [FormTextFieldSectionModel] {
      textFieldModels
        .map { $0.title }
        .unique()
        .map { title -> FormTextFieldSectionModel in
          let items = textFieldModels.filter { $0.title == title }
          return FormTextFieldSectionModel(header: title, items: items)
        }
    }
    
  internal func makeValidatorPublisher(with fields: [TextFieldCellViewModel]) -> AnyPublisher<Bool, Never> {
    let validator = fields
      .filter {  $0.validation != nil }
      .map { $0.validationPublisher }
      .combineLatest
      .map { $0.allSatisfy { $0 == true } }
      
    return validator.eraseToAnyPublisher()
  }
}


class FormAddPetViewModel: FormViewModelable {
    struct Input {
        let btnAddTap: UIControlPublisher<UIControl>
    }

    struct Output {
        let btnAddTapped: AnyPublisher<UIControl, Never>
        let isValid: AnyPublisher<Bool, Never>
        let data: AnyPublisher<[FormTextFieldSectionModel], Never>
    }

    private var navigator: PetNavigator

    init(navigator: PetNavigator) {
        self.navigator = navigator
    }

    func fields() -> [TextFieldCellViewModel] {
          return TextFieldCellViewModel.Mocked()
    }
    

    
    func transform(input: Input) -> Output {
       let rawData = fields()
       let data = transformToTextFieldSections(rawData)
       let validators = makeValidatorPublisher(with: rawData)
       let dataPublisher = CurrentValueSubject<[FormTextFieldSectionModel], Never>(data)
     
        let tapped = input.btnAddTap
            .handleEvents(receiveOutput: { [weak self] _ in
                print("receiveOutput add pet viewmodel")
            }, receiveCompletion: {
                print("receiveCompletion \($0)")
            }, receiveCancel: {
                print("receiveCancel CANCEL")
            })
            .eraseToAnyPublisher()

        
        return Output(btnAddTapped: tapped,
                     isValid: validators.eraseToAnyPublisher(),
                     data: dataPublisher.eraseToAnyPublisher())
    }
}



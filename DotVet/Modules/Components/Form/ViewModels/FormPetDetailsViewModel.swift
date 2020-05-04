//
//  FormPetDetailsViewModel.swift
//  DotVet
//
//  Created by Jose Frometa on 5/3/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//


import Combine
import UIKit

class FormPetDetailsViewModel: FormViewModelable {
    private var navigator: PetNavigator

    init(navigator: PetNavigator) {
        self.navigator = navigator
    }

    func fields() -> [TextFieldCellViewModel] {
          return TextFieldCellViewModel.Mocked2()
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



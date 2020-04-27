//
//  PetViewModel.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import UIKit

class FormAddPetViewModel: ViewModelType {
    struct Input {
        let btnAddTap: UIControlPublisher<UIControl>
    }

    struct Output {
        let btnAddTapped: AnyPublisher<UIControl, Never>
    }

    private var navigator: PetNavigator

    init(navigator: PetNavigator) {
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let tapped = input.btnAddTap
            .handleEvents(receiveOutput: { [weak self] _ in
                print("receiveOutput add pet viewmodel")
            }, receiveCompletion: {
                print("receiveCompletion \($0)")
            }, receiveCancel: {
                print("receiveCancel CANCEL")
            })
            .eraseToAnyPublisher()

        return Output(btnAddTapped: tapped)
    }
}

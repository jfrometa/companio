//
//  DefaultPetNavigator.swift
//  DotVet
//
//  Created by Jose Frometa on 4/11/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol PetNavigator: class, UINavigator {
    func goToAddPet()
}

class DefaultPetNavigator: PetNavigator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToAddPet() {
        let vm = AddPetViewModel(navigator: self)
        let vc = AddPetViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

//
//  DefaultPetNavigator.swift
//  DotVet
//
//  Created by Jose Frometa on 4/11/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol PetNavigator: class, UINavigator {
    func goToAddPetIdentity()
    func goToAddPetDetails()
}

class DefaultPetNavigator: PetNavigator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToAddPetIdentity() {
        let vm = FormPetIdentityViewModel(navigator: self)
        let vc = FormViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAddPetDetails() {
        let vm = FormPetDetailsViewModel(navigator: self)
        let vc = FormViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

//
//  NavigationProtocols.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol UINavigator {
    var navigationController: UINavigationController { get }
}

protocol NavigationComposer: class {
    static var shared: NavigationComposer? { get }
    func getDefaultPetNavigator() -> PetNavigator
}

class DefaultNavigatonComposer: NavigationComposer {
    static var shared: NavigationComposer?
    private let navigationController: UINavigationController
    
    private init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    @discardableResult
    static func build(navigationController: UINavigationController) -> NavigationComposer {
        if let composer = self.shared {
            return composer
        } else {
            return DefaultNavigatonComposer(navigationController: navigationController)
        }
    }
    
    private var defaultPetNavigator: PetNavigator?
    func getDefaultPetNavigator() -> PetNavigator {
        if let navigator = defaultPetNavigator {
            return navigator
        } else {
            let navigator =  DefaultPetNavigator(navigationController: self.navigationController)
            self.defaultPetNavigator = navigator
            return navigator
       }
    }
}

//
//  SceneDelegate.swift
//  DotVet
//
//  Created by Jose Frometa on 4/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        initApp(with: scene)
    }

    private func initApp(with scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let navigationController = UINavigationController()
        let navigator = DefaultNavigatonComposer
            .build(navigationController: navigationController)
            .getDefaultPetNavigator()

        let vm = AddPetViewModel(navigator: navigator)
        let vc = AddPetViewController(viewModel: vm)

        navigationController.setViewControllers([vc], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  DotVet
//
//  Created by Jose Frometa on 4/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

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
        IQKeyboardManager.shared.disabledToolbarClasses = [FormViewController.self]
        // ignores the user theme settings and enforces .lightMode
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        let navigationController = UINavigationController()
        let navigator = DefaultNavigatonComposer
            .build(navigationController: navigationController)
            .getDefaultPetNavigator()

        let vm = FormPetIdentityViewModel(navigator: navigator)
        let vc = FormViewController(viewModel: vm)

        navigationController.setViewControllers([vc], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  DotVet
//
//  Created by Jose Frometa on 4/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.initApp(with: scene)
    }
    
    private func initApp(with scene: UIScene) {
         guard let windowScene = scene as? UIWindowScene else { return }
         self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
         self.window?.windowScene = windowScene
         
         let navigationController = UINavigationController()
         let navigator = DefaultNavigatonComposer
                 .build(navigationController: navigationController)
                 .getDefaultPetNavigator()
        
          let vm = AddPetViewModel(navigator: navigator)
          let vc = AddPetViewController(viewModel: vm)
        
          navigationController.setViewControllers([vc], animated: false)
          self.window?.rootViewController = navigationController
          self.window?.makeKeyAndVisible()
    }
}


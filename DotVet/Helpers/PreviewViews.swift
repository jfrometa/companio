//
//  PreviewViews.swift
//  DotVet
//
//  πCreated by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation
import SwiftUI

struct ControllerPreview: PreviewProvider, UIViewControllerRepresentable {
    func makeUIViewController(context _: Context) -> PetViewController {
        let navigator = DefaultPetNavigator(navigationController: UINavigationController())
        let vm = PetViewModel(navigator: navigator)
        let vc = PetViewController(viewModel: vm)
        return vc
    }

    func updateUIViewController(_: PetViewController, context _: Context) {}

    static var previews: some View {
        ControllerPreview()
    }

    typealias UIViewControllerType = PetViewController
}

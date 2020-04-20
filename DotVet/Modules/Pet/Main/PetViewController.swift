//
//  FirstViewController.swift
//  DotVet
//
//  Created by Jose Frometa on 4/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import UIKit

class PetViewController: UIViewController {
    private var mainView: PetView!
    private let viewModel: PetViewModel
    private var cancellableBag = Set<AnyCancellable>()

    init(viewModel: PetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        mainView = PetView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        let btnControl = mainView.btnAdd.publisher(for: [.touchUpInside])
        let output = viewModel.transform(input: PetViewModel.Input(btnAddTap: btnControl))

        output.btnAddTapped
            .map(\.isTouchInside)
            .assign(to: \.isSelected, on: mainView.btnAdd)
            .store(in: &cancellableBag)
    }
}

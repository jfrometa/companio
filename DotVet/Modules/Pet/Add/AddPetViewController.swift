//
import Combine
//  AddPetViewController.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//
import UIKit

class AddPetViewController: UIViewController {
    private var mainView: AddPetView!
    private let viewModel: AddPetViewModel
    private var cancellableBag = Set<AnyCancellable>()

    init(viewModel: AddPetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        mainView = AddPetView(frame: .zero)
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        let btnControl = mainView.btnContinue.publisher(for: [.touchUpInside])
        let output = viewModel.transform(input: AddPetViewModel.Input(btnAddTap: btnControl))

        output.btnAddTapped
            .handleEvents(receiveOutput: { [weak self] _ in
                print("print AddPetViewController")
                // self?.mainView.endEditing(true)
            })
            .map { _ in true }
            .assign(to: \.isSelected, on: mainView.btnContinue)
            .store(in: &cancellableBag)
    }
}

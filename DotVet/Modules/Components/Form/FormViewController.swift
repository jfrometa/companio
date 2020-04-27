
//  AddPetViewController.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//
import Combine
import UIKit

class FormViewController: UIViewController {
    private var mainView: FormView
    private let viewModel: FormAddPetViewModel
    private var dataSource: FormViewDataSource
    private var cancellableBag = Set<AnyCancellable>()
    
    init(viewModel: FormAddPetViewModel) {
        self.viewModel = viewModel
        self.mainView = FormView(frame: .zero)
        self.dataSource = FormViewDataSource()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = self.mainView
        mainView.tableView.dataSource = dataSource
        mainView.tableView.delegate = dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        
        let mocked = FormTextFieldSectionModel(header: "TITLE / HEADER 1!",
                                           items: [TextFieldCellViewModel.Mocked(),
                                           TextFieldCellViewModel.Mocked2()])
        
        let mocked2 = FormTextFieldSectionModel(header: "TITLE/HEADER 2 !!",
                                            items: [TextFieldCellViewModel.Mocked(),
                                            TextFieldCellViewModel.Mocked(),
                                            TextFieldCellViewModel.Mocked(),
                                            TextFieldCellViewModel.Mocked2()])

        dataSource.update([mocked] + [mocked2])
    }

    private func bindViewModel() {
        let btnControl = mainView.btnContinue.publisher(for: [.touchUpInside])
        let output = viewModel.transform(input: FormAddPetViewModel.Input(btnAddTap: btnControl))

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

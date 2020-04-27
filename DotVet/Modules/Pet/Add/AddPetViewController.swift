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
    private var mainView: FormView
    private let viewModel: AddPetViewModel
    private var cancellableBag = Set<AnyCancellable>()
    private var dataSource: FormViewDataSource
    
    init(viewModel: AddPetViewModel) {
        self.viewModel = viewModel
        self.mainView = FormView(frame: .zero)
        let mocked = FormTextFieldSectionModel(header: "TITLE/HEADER",
                                                items: [TextFieldCellViewModel.Mocked(),
                                                        TextFieldCellViewModel.Mocked(),
                                                        TextFieldCellViewModel.Mocked(),
                                                        TextFieldCellViewModel.Mocked()])
        self.dataSource = FormViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = self.mainView
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        
        let mocked = FormTextFieldSectionModel(header: "TITLE/HEADER !",
                                            items: [TextFieldCellViewModel.Mocked(),
                                                    TextFieldCellViewModel.Mocked(),
                                                    TextFieldCellViewModel.Mocked(),
                                                    TextFieldCellViewModel.Mocked2()])
        
        let mocked2 = FormTextFieldSectionModel(header: "TITLE/HEADER  !!",
        items: [TextFieldCellViewModel.Mocked2(),
                TextFieldCellViewModel.Mocked(),
                TextFieldCellViewModel.Mocked(),
                TextFieldCellViewModel.Mocked()])
        
        self.dataSource.update([mocked] + [mocked2])
        self.mainView.tableView.dataSource = self.dataSource
        self.mainView.tableView.delegate = self.dataSource
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

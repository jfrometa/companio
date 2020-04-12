//
//  AddPetViewController.swift
//  DotVet
//
//  Created by Jose Frometa on 4/12/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//
import UIKit
import Combine

class AddPetViewController: UIViewController {
    private var mainView: AddPetView!
    private let viewModel: AddPetViewModel
    private var cancellableBag = Set<AnyCancellable>()
    
    init(viewModel: AddPetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.mainView = AddPetView(frame: .zero)
        self.view = mainView
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.bindViewModel()
    }

    private func bindViewModel(){
       let btnControl = self.mainView.btnContinue.publisher(for: .touchUpInside)
       let output = self.viewModel.transform(input: AddPetViewModel.Input(btnAddTap: btnControl))
   
//        output.btnAddTapped
//            .map(\.isTouchInside)
//            .assign(to: \.isEnabled, on: self.mainView.btnAdd)
//           . store(in: &cancellableBag)
//
        
        output.btnAddTapped
         .map(\.isTouchInside)
         .assign(to: \.isSelected, on: self.mainView.btnContinue)
        . store(in: &cancellableBag)
    }
}



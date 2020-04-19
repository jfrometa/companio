//
//  FormCellView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import MaterialComponents

protocol TextFieldHandler: UITextFieldDelegate {
    var hidesPlaceholderOnInput: Bool { get set}
    var returnKeyType: UIReturnKeyType { get set }
    var isValidInput: () -> Bool { get }
}

extension FormRowView: TextFieldHandler {
    var isValidInput: () -> Bool {
        { return true }
    }
    
    var hidesPlaceholderOnInput: Bool {
        get { self.textfield.hidesPlaceholderOnInput }
        set { self.textfield.hidesPlaceholderOnInput = newValue }
    }

    var returnKeyType: UIReturnKeyType {
        get { self.textfield.returnKeyType }
        set { self.textfield.returnKeyType = newValue }
    }
}

class FormRowView: UIView {
   private var tfController: MDCTextInputControllerUnderline?
   private let textfield: MDCTextField = {
       let tf = MDCTextField().withAutoLayout()
       tf.standar()
       return tf
   }()
    
   init(viewModel: FormViewModel? = nil) {
      self.tfController = MDCTextInputControllerUnderline(textInput: textfield)
      super.init(frame: .zero)
      self.setView()
      self.setContraints()
      self.subscribeEvents()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.tfController?.start(textfield, placeHolder: "UN PLACEHOLDER")
        self.addSubview(textfield)
    }
    
    private func setContraints() {
        textfield
            .constrain(top: safeTopAnchor,
                      leading: safeLeadingAnchor,
                      bottom: safeBottomAnchor,
                      trailing: safeTrailingAnchor,
                      padding: .init(top: 0, left: 10, bottom: -15, right: 0))
    }
    
    private func subscribeEvents() {
        
    }
}

extension FormRowView {
    func createCell() {
        
    }
    
}

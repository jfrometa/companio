//
//  FormCellView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol TextFieldHandler: UITextFieldDelegate {
    var isPlaceHolderHidden: Bool { get set}
    var returnKeyType: UIReturnKeyType { get set }
}


class FormCellView: UIView {
    private let container: UIView = {
      let view = UIView().withAutoLayout()
      return view
    }()

    private let textfield: UITextField = {
      let tf = UITextField().withAutoLayout()
       tf.returnKeyType = .done
       tf.autocorrectionType = .no
       tf.borderWidth = 1
       tf.borderColor = .red
      return tf
    }()

    private var label: UILabel = {
      let lbl = UILabel()
      lbl.layer.borderWidth = 1
      lbl.layer.borderColor = UIColor.green.cgColor
      lbl.attributedText = "Atributed Name".formatTextWithFont(size: 16, color: .darkGray)
      lbl.numberOfLines = 4
      lbl.textAlignment = .left
      
      return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FormCellView {
    func createCell() {
        
    }
    
}

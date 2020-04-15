//
//  UISTextField.swift
//  DotVet
//
//  Created by Jose Frometa on 4/13/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine


protocol TextFieldHandler: UITextFieldDelegate {}

class UISTextField: UIView, TextFieldHandler {
  private let stackView: UIStackView = {
    let stackView = UIStackView().withAutoLayout()
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
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
    lbl.attributedText = "Name".formatTextWithFont(size: 16, color: .darkGray)
    lbl.numberOfLines = 4
    lbl.textAlignment = .left

    return lbl
  }()


  override init(frame: CGRect = .zero) {
     super.init(frame:frame)
     self.setView()
     self.setConstraints()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    var isPlaceHolderHidden: Bool = true {
        didSet {
            self.label.isHidden = isPlaceHolderHidden
            
        }
    }
    
  private func setView() {
    self.backgroundColor = .clear
    textfield.delegate = self

    self.addSubview(stackView)
    
    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(textfield)
    
//     let subscriber = Subscribers.Assign(object: textfield, keyPath: \.text)
//     NotificationCenter.default
//        .publisher(for: UITextField.textDidEndEditingNotification, object: textfield)
//        .map(\.object)
//        .map { ($0 as? UITextField) }
//        .map { $0?.text }
//        .handleEvents( receiveOutput: { [weak self] _ in
//            self?.textfield.becomeFirstResponder()
//          // print("receiveOutput UITextField \($0 ?? "error")")
//         }, receiveCompletion: {
//           print("receiveCompletion \($0)")
//         }, receiveCancel: {
//           print("receiveCancel CANCEL")
//         })
//        .receive(on: DispatchQueue.main)
//        .subscribe(subscriber)
        
    
        
    
  }
    
  private func setConstraints() {
    stackView.constrain(top: self.topAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor,
                     padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    
    guard let sv = textfield.superview else { return }
    label.constrain(leading: sv.leadingAnchor, 
                  trailing: sv.trailingAnchor,
                  padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    
    textfield.constrain(leading: sv.leadingAnchor,
                    trailing: sv.trailingAnchor,
                    padding: .init(top: 5, left: 20, bottom: 5, right: 20))
   }
}

//
//  PetView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine

class AddPetView: UIView {
  private let stackView: ScrollingStackView = {
    let stackView = ScrollingStackView()
       .withAutoLayout()
    
    stackView.spacing = 20
    stackView.layer.borderColor = UIColor.blue.cgColor
    stackView.layer.borderWidth = 2
    return stackView
  }()

  private let tfName: UITextField = {
    let tf = UITextField().withAutoLayout()
     tf.returnKeyType = .next
     tf.placeholder = "name"
    tf.autocorrectionType = .no
    return tf
  }()

  private let tfRace: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.returnKeyType = .next
    tf.placeholder = "Pitbul"
    tf.autocorrectionType = .no
    return tf
  }()

  private let tfPet: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.returnKeyType = .next
    tf.placeholder = "Dog"
    tf.autocorrectionType = .no
    return tf
  }()

  private let tfBirthDate: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.setDatePickerAsTextInput()
    tf.placeholder = "Birth Date"
    tf.borderStyle = .roundedRect
    tf.keyboardAppearance = .light
    tf.returnKeyType = .done
    tf.autocorrectionType = .no
    return tf
  }()

  private let tfCity: UITextField = {
    let tf = UITextField().withAutoLayout()
     tf.returnKeyType = .continue
    tf.autocorrectionType = .no
    return tf
  }()

  private let tfCountry: UITextField = {
    let tf = UITextField().withAutoLayout()
     tf.returnKeyType = .continue
    tf.isUserInteractionEnabled = false
    return tf
  }()
    
    
//    var name: String { get }
//    var race: String? { get }
//    var birthDate: String? { get }
//    var address: String? { get }
//    var owners: [String]? { get }
//    var picture: String? { get }
//    var weight: String? { get }
  private var lblName: UILabel = {
    let lbl = UILabel()
        .withAutoLayout()
    lbl.attributedText = "Name".formatTextWithFont(size: 22)
    lbl.numberOfLines = 0
    lbl.textAlignment = .center

    return lbl
  }()

  private var lblRace: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.textAlignment = .center
    return lbl
  }()

  let btnContinue: UIButton = {
    let btn = UIButton(type: .roundedRect).withAutoLayout()
    btn.setTitle("Confirmar", for: .normal)
    btn.frame = CGRect(x: 0, y: 0, width: 271, height: 52)
    return btn
  }()

  override init(frame: CGRect) {
     super.init(frame:frame)
     setView()
     setConstraints()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setView() {
    self.backgroundColor = .white
    self.addSubview(stackView)
    self.addSubview(btnContinue)
    
    stackView.addArrangedSubview(lblName)
    stackView.addArrangedSubview(tfName)
    stackView.addArrangedSubview(lblRace)
    stackView.addArrangedSubview(tfRace)
    stackView.addArrangedSubview(tfPet)
    stackView.addArrangedSubview(tfBirthDate)
    stackView.addArrangedSubview(tfCity)
    stackView.addArrangedSubview(tfCountry)
    
     let subscriber = Subscribers.Assign(object: tfName, keyPath: \.text)
     NotificationCenter.default
        .publisher(for: UITextField.textDidEndEditingNotification, object: tfName)
        .map(\.object)
        .map { ($0 as? UITextField) }
        .map { $0?.text }
        .handleEvents( receiveOutput: { [weak self] _ in
            self?.tfPet.becomeFirstResponder()
          // print("receiveOutput UITextField \($0 ?? "error")")
         }, receiveCompletion: {
           print("receiveCompletion \($0)")
         }, receiveCancel: {
           print("receiveCancel CANCEL")
         })
        .receive(on: DispatchQueue.main)
        .subscribe(subscriber)
        
    
    tfName.delegate = self
    tfName.delegate = self
    tfBirthDate.delegate = self
    tfCity.delegate = self
    tfBirthDate.delegate = self
    tfCountry.delegate = self
  }
    
  private func setConstraints() {
     stackView.anchor(top: safeTopAnchor,
                     leading: leadingAnchor,
                     bottom: btnContinue.topAnchor,
                     trailing: trailingAnchor,
                     padding: .init(top: 20, left: 17, bottom: 20, right: 17))
    
      btnContinue.anchor(bottom: safeBottomAnchor,
                       centerX: centerXAnchor,
                       padding: .init(top: 0, left: 0, bottom: 40, right: 0),
                       size: .init(width: 270, height: 52))
   }
}

extension AddPetView: UITextFieldDelegate {
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      switch textField.returnKeyType {
        case .next, .continue:
            textField.endEditing(true)
        default:
            textField.resignFirstResponder()
      }
      return true
   }

    
  func goToNextElement() {
    guard let subViews = self.superview?.subviews else { return }
          subViews
            .forEach {
                guard let nextResponder = $0.viewWithTag(self.tag)
                    else {  print("klk not") ;return  }
                
                print("klk")
              //  nextResponder.becomeFirstResponder()
          }
    }
}

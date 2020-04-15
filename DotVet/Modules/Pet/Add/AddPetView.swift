//
//  PetView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit
import Combine



//
//extension AdjustableForKeyboard {
//    NotificationCenter.default.addObserver(self,
//                            selector: #selector(adjustForKeyboard),
//                            name: UIResponder.keyboardWillHideNotification,
//                            object: nil)
//    NotificationCenter.default.addObserver(self,
//                            selector: #selector(adjustForKeyboard),
//                            name: UIResponder.keyboardWillChangeFrameNotification,
//                            object: nil)
//
//    @objc func adjustForKeyboard(notification: Notification) {
//        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//
//        let keyboardScreenEndFrame = keyboardValue.cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//        if notification.name == UIResponder.keyboardWillHideNotification {
//            yourTextView.contentInset = .zero
//        } else {
//            yourTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
//        }
//
//        yourTextView.scrollIndicatorInsets = yourTextView.contentInset
//
//        let selectedRange = yourTextView.selectedRange
//        yourTextView.scrollRangeToVisible(selectedRange)
//    }
//}
protocol AdjustableForKeyboard: class {
    func subscribeToKeyboard(store: inout Set<AnyCancellable>)
}

protocol FieldConnectable: AdjustableForKeyboard {
   func connectTextFields()
}
extension ScrollingStackView: FieldConnectable {
    func subscribeToKeyboard(store: inout Set<AnyCancellable>) {
        let keyboardWillOpen = NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap {$0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect}
          //  .map {$0.height}
            .map { [unowned self] in return self.convert($0, from: self.window) }
            .map {[unowned self] in return ($0.height - self.safeAreaInsets.bottom) }
            .print()

        let keyboardWillHide =  NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0)}
        
        return Publishers
          .Merge(keyboardWillOpen, keyboardWillHide)
          .subscribe(on: RunLoop.main)
          .assign(to: \UIScrollView.contentInset.bottom, on: self)
          .store(in: &store)
    }
    
    func connectTextFields() {
        let textFields = arrangedSubviews.compactMap { $0 as? UITextField }
        UITextField.connectNextKeyboardReturnKey(for : textFields)
    }
}


class AddPetView: UIView {
  private let stackView: ScrollingStackView = {
    let stackView = ScrollingStackView()
       .withAutoLayout()
    
    stackView.spacing = 20
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
    tf.beginFloatingCursor(at: CGPoint(x: 2, y: 0))
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
    let text = UISTextField()
    func toglePlaceHolder() {
        text.isPlaceHolderHidden = false
    }

  private func setView() {
    self.backgroundColor = .white
    self.addSubview(stackView)
    self.addSubview(btnContinue)
    
    stackView.addArrangedSubview(lblName)
    
    
    stackView.addArrangedSubview(text)
    
    stackView.addArrangedSubview(tfName)
    stackView.addArrangedSubview(lblRace)
    stackView.addArrangedSubview(tfRace)
    stackView.addArrangedSubview(tfPet)
    stackView.addArrangedSubview(tfBirthDate)
    stackView.addArrangedSubview(tfCity)
    stackView.addArrangedSubview(tfCountry)
    
    stackView.connectTextFields()
//     let subscriber = Subscribers.Assign(object: tfName, keyPath: \.text)
//     NotificationCenter.default
//        .publisher(for: UITextField.textDidEndEditingNotification, object: tfName)
//        .map(\.object)
//        .map { ($0 as? UITextField) }
//        .map { $0?.text }
//        .handleEvents( receiveOutput: { [weak self] _ in
//            self?.tfPet.becomeFirstResponder()
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
     stackView.constrain(top: btnContinue.bottomAnchor,
                     leading: leadingAnchor,
                     bottom: safeBottomAnchor,
                     trailing: trailingAnchor,
                     padding: .init(top: 20, left: 17, bottom: 20, right: 17))
    
    btnContinue.constrain(top: safeTopAnchor,
                       leading: leadingAnchor,
                        trailing: trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 10, right: 0),
                        size: .init(width: 0, height: 52))
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

    
//  func goToNextElement() {
//    guard let subViews = self.superview?.subviews else { return }
//          subViews
//            .forEach {
//                guard let nextResponder = $0.viewWithTag(self.tag)
//                    else {  print("klk not") ;return  }
//
//                print("klk")
//              //  nextResponder.becomeFirstResponder()
//          }
//    }
}

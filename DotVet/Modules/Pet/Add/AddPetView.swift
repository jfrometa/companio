//
//  PetView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Combine
import MaterialComponents
import UIKit

class AddPetView: UIView {
    private let stackView: ScrollingStackView = {
        let stackView = ScrollingStackView()
            .withAutoLayout()

        stackView.spacing = 20
        return stackView
    }()

    private let tfFormRowView: FormRowView = {
        let tf = FormRowView(viewModel: nil).withAutoLayout()
        tf.returnKeyType = .next
        tf.backgroundColor = .red
        return tf
    }()

    private let tfPet: MDCTextField = {
        let tf = MDCTextField().withAutoLayout()
        tf.beginFloatingCursor(at: CGPoint(x: 2, y: 0))
        tf.returnKeyType = .next
        tf.backgroundColor = .green
        tf.placeholder = "Dog"
        tf.autocorrectionType = .no
        return tf
    }()

    private let tfBirthDate: MDCTextField = {
        let tf = MDCTextField().withAutoLayout()
        tf.setDatePickerAsTextInput()
        tf.placeholder = "Birth Date"
        tf.keyboardAppearance = .light
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        return tf
    }()

    let btnContinue: UIButton = {
        let btn = UIButton(type: .roundedRect).withAutoLayout()
        btn.setTitle("Confirmar", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 271, height: 52)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        backgroundColor = .white
        addSubview(stackView)
        addSubview(btnContinue)

        stackView.addArrangedSubview(tfFormRowView)
        stackView.addArrangedSubview(tfPet)
        stackView.addArrangedSubview(tfBirthDate)

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

//
//  PetView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

class AddPetView: UIView {
//  public var formSubmitted = PublishSubject<[CardCacaoOrderRequestBuilder.keys: String]>()
//  private let disposeBag = DisposeBag()

  private let stackView: ScrollingStackView = {
    let stackView = ScrollingStackView().withAutoLayout()
    stackView.spacing = 10
    return stackView
  }()

 // private var tfFullLegalNameController: MDCTextInputControllerUnderline?
  private let tfFullLegalName: UITextField = {
    let tf = UITextField().withAutoLayout()
 //   tf.setOrderCardStyle()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
    return tf
  }()

  //private var tfAddressLine1Controller: MDCTextInputControllerUnderline?
  private let tfAddressLine1: UITextField = {
    let tf = UITextField().withAutoLayout()
   // tf.setOrderCardStyle()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
    return tf
  }()

 // private var tfAddressLine2Controller: MDCTextInputControllerUnderline?
  private let tfAddressLine2: UITextField = {
    let tf = UITextField().withAutoLayout()
   // tf.setOrderCardStyle()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
   // tf.placeholder = "card.order_card.mailing_address.address_line_2".localized()
    return tf
  }()

  //private var tfPostalCodeController: UITextField?
  private let tfPostalCode: UITextField = {
    let tf = UITextField().withAutoLayout()
    //tf.setOrderCardStyle()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
  //  tf.placeholder = "card.order_card.mailing_address.postal_code".localized()
    return tf
  }()

  //private var tfCityController: MDCTextInputControllerUnderline?
  private let tfCity: UITextField = {
    let tf = UITextField().withAutoLayout()
    //tf.setOrderCardStyle()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
   // tf.placeholder = "card.order_card.mailing_address.city".localized()
    return tf
  }()

  //private var tfCountryController: MDCTextInputControllerUnderline?
  private let tfCountry: UITextField = {
    let tf = UITextField().withAutoLayout()
    tf.frame = CGRect(x: 0, y: 0, width: 0, height: 68)
    tf.isUserInteractionEnabled = false
    return tf
  }()

  private var firstSectionSubtitle: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.textAlignment = .center

    return lbl
  }()

  private var secondSectionTitle: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.textAlignment = .center
    return lbl
  }()

  let btnContinue: UIButton = {
    let btn = UIButton().withAutoLayout()
    btn.frame = CGRect(x: 0, y: 0, width: 271, height: 52)
    return btn
  }()


   override init(frame: CGRect) {
           super.init(frame:frame)
         //  self.translatesAutoresizingMaskIntoConstraints = false
           self.backgroundColor = .white
   }
    
   override func didMoveToSuperview() {
         setView()
         setConstraints()
   }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setView() {
    backgroundColor = .white
    
    stackView.addArrangedSubview(firstSectionSubtitle)
    stackView.addArrangedSubview(tfFullLegalName)
    stackView.addArrangedSubview(secondSectionTitle)
    stackView.addArrangedSubview(tfAddressLine1)
    stackView.addArrangedSubview(tfAddressLine2)
    stackView.addArrangedSubview(tfPostalCode)
    stackView.addArrangedSubview(tfCity)
    stackView.addArrangedSubview(tfCountry)

    addSubview(stackView)
    addSubview(btnContinue)
  }
    
  private func setConstraints() {
        guard let sv = self.superview else { return }
//          self.anchor(top: sv.safeTopAnchor,
//                 leading: sv.leadingAnchor,
//                 bottom: sv.safeBottomAnchor,
//                 trailing: sv.trailingAnchor)
//
//          btnAdd.anchor(bottom: safeBottomAnchor,
//                        centerX: centerXAnchor,
//                        padding: .init(top: 0, left: 0, bottom: 40, right: 0))
   }
}

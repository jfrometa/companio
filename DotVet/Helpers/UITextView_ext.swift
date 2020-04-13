////
////  UITextView_ext.swift
////  DotVet
////
////  Created by Jose Frometa on 4/12/20.
////  Copyright © 2020 Upgrade. All rights reserved.
////
//
//import UIKit
//
//protocol NextableView: UITextFieldDelegate { }
//extension UITextField: NextableView {}
//
//extension NextableView where Self == UITextField {
//    func setDeletgate(_ delegate: UITextFieldDelegate) {
//        self.delegate = delegate
//    }
//    
//    func setNextTextField(_ field: UITextField) {
//        field.becomeFirstResponder()
//    }
//    
//   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    
//    if textField.returnKeyType == .next {
//        self.goToNextElement()
//    }else{
//        self.resignFirstResponder()
//    }
//        return true
//    }
//    
//  func goToNextElement() {
//        self.superview?
//            .subviews
//            .forEach {
//                guard let nextResponder = $0 as? UITextView
//                else {
//                    self.resignFirstResponder() ; return
//                }
//                nextResponder.becomeFirstResponder()
//            }
//    }
//}

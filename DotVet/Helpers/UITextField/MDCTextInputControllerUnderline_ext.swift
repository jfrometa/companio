//
//  MDCTextInputControllerUnderline_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/19/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents
import UIKit

extension MDCTextInputControllerUnderline {
    func setNormalState(_ textField: MDCTextField) {
        textField.autocorrectionType = .no
        textField.cursorColor = UIColor.lightGray
    }

    func checkErrorForRefresh() {
        guard let removeError = errorText?.count else { return }
        if removeError > 1 { setErrorText(nil, errorAccessibilityValue: nil) }
    }

    func start(_ textField: MDCTextField,
               placeHolder: String? = nil,
               placeHolderImage: String? = nil) {
        textInputFont = UIFont.systemFont(ofSize: 16)
        inlinePlaceholderFont = UIFont.systemFont(ofSize: 14.0)

        if let text = placeHolder, let imageName = placeHolderImage {
            let attachment = NSTextAttachment()
            let attributedString = NSMutableAttributedString()

            attachment.image = UIImage(named: imageName)

            let iconString = NSAttributedString(attachment: attachment)
            attributedString.append(iconString)

            let imageWidth = (attachment.image?.size.width)!
            let imageHeight = (attachment.image?.size.height)!
            attachment.bounds = CGRect(x: 0, y: 20, width: imageWidth, height: imageHeight)

            let firstString = "".formatTextWithFont(size: 14)
            let secondString = text.formatTextWithFont(size: 14)

            firstString.append(attributedString)
            firstString.append(secondString)

            textInput?.attributedPlaceholder = firstString
        } else if let text = placeHolder {
            textInput?.attributedPlaceholder = text.formatTextWithFont(size: 14)
        }

        inlinePlaceholderColor = .lightGray
        floatingPlaceholderActiveColor = .darkGray
        floatingPlaceholderNormalColor = .gray
        activeColor = .darkGray
        normalColor = .gray

        // replace clear image
        let image = UIImage(named: "type_cancel")?
            .withRenderingMode(UIImage.RenderingMode.automatic)

        let b = textInput?.clearButton
        b?.setImage(image, for: .normal)

        setNormalState(textField)
    }
}

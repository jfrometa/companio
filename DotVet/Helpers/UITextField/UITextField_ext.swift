import UIKit

extension UITextField {
    class func connectNextKeyboardReturnKey(for fields: [UITextField]) {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i + 1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}

extension UITextField {
    var placeHolderColor: UIColor? {
        get { self.placeHolderColor }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

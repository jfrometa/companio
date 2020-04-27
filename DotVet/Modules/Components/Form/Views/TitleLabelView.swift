import UIKit

class TitleLabelView: UIView {
    let header = UIView().withAutoLayout()
    let title = UILabel().withAutoLayout()
    
  init(frame: CGRect = .zero, message: String) {
    super.init(frame: frame)
    self.setView(message: message)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  private func setView(message: String) {

    title.attributedText = message.formatTextWithFont()
    header.addSubview(title)
    
    addSubview(header)
    
    
    header.constrain(top: topAnchor,
                     leading: leadingAnchor,
                    bottom: bottomAnchor,
                    trailing: trailingAnchor,
                    size: .init(width: 200, height: 70))
    
    title.constrain(top: header.topAnchor,
                    leading: header.leadingAnchor,
                    bottom: header.bottomAnchor,
                    trailing: header.trailingAnchor,
                    padding: .init(top: 8, left: 20, bottom: 8, right: 20))

  }
}

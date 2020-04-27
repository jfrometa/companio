import UIKit

class TitleLabelView: UIView {
    let title = UILabel().withAutoLayout()

    init(frame: CGRect = .zero, message: String) {
        super.init(frame: frame)
        setView(message: message)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setView(message: String) {
        self.title.attributedText = message.formatTextWithFont()
        addSubview(title)

        self.title.constrain(top: topAnchor,
                        leading: leadingAnchor,
                        bottom:bottomAnchor,
                        trailing: trailingAnchor,
                        padding: .init(top: 8, left: 20, bottom: 8, right: 20))
    }
}

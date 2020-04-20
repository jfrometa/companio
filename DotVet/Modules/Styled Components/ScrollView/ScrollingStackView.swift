/**
 ScrollingStackView
 https://sintraworks.github.io/swift/uikit/2018/12/24/scrolling-stackview.html
 */

import UIKit

class ScrollingStackView: UIScrollView {
    private var stackView = UIStackView()
    private var axisConstraint: NSLayoutConstraint?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(axis: .vertical)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(axis: .vertical)
    }

    init(axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: CGRect.zero)
        commonInit(axis: axis)
    }

    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .vertical) {
        self.init(axis: axis)
        for subview in arrangedSubviews {
            stackView.addArrangedSubview(subview)
        }
    }

    private func commonInit(axis: NSLayoutConstraint.Axis) {
        embed(stackView)
        self.axis = axis
    }
}

// MARK: Managing arranged subviews

extension ScrollingStackView {
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    var arrangedSubviews: [UIView] {
        return stackView.arrangedSubviews
    }

    func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }

    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }
}

// MARK: Configuring the layout

extension ScrollingStackView {
    var alignment: UIStackView.Alignment {
        get { return stackView.alignment }
        set { stackView.alignment = newValue }
    }

    var axis: NSLayoutConstraint.Axis {
        get { return stackView.axis }
        set {
            axisConstraint?.isActive = false // deactivate existing constraint, if any
            switch newValue as NSLayoutConstraint.Axis {
            case .vertical:
                axisConstraint = stackView.widthAnchor.constraint(equalTo: widthAnchor)
            case .horizontal:
                axisConstraint = stackView.heightAnchor.constraint(equalTo: heightAnchor)
            default:
                // HANDLE DEFAULT
                break
            }
            axisConstraint?.isActive = true // activate new constraint

            stackView.axis = newValue
        }
    }

    var isBaselineRelativeArrangement: Bool {
        get { return stackView.isBaselineRelativeArrangement }
        set { stackView.isBaselineRelativeArrangement = newValue }
    }

    var distribution: UIStackView.Distribution {
        get { return stackView.distribution }
        set { stackView.distribution = newValue }
    }

    var isLayoutMarginsRelativeArrangement: Bool {
        get { return stackView.isLayoutMarginsRelativeArrangement }
        set { stackView.isLayoutMarginsRelativeArrangement = newValue }
    }

    var spacing: CGFloat {
        get { return stackView.spacing }
        set { stackView.spacing = newValue }
    }
}

// MARK: Adding space between items

@available(iOS 11.0, *)
extension ScrollingStackView {
    func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        return stackView.customSpacing(after: arrangedSubview)
    }

    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }

    class var spacingUseDefault: CGFloat {
        return UIStackView.spacingUseDefault
    }

    class var spacingUseSystem: CGFloat {
        return UIStackView.spacingUseSystem
    }
}

// MARK: - UIView overrides

extension ScrollingStackView {
    override var layoutMargins: UIEdgeInsets {
        get { return stackView.layoutMargins }
        set { stackView.layoutMargins = newValue }
    }
}

extension UIView {
    func embed(_ child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
        let constraints = [
            child.leftAnchor.constraint(equalTo: self.leftAnchor),
            child.rightAnchor.constraint(equalTo: self.rightAnchor),
            child.topAnchor.constraint(equalTo: self.topAnchor),
            child.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

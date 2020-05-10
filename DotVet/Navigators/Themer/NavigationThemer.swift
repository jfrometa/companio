//
//  NavigationThemer.swift
//  DotVet
//
//  Created by Jose Frometa on 5/9/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//


import UIKit
import Combine

enum NavigationControllerStyle {
  case withBackButton
  case withBackButtonAndCancelButton
  case cancelOnly
  case titleOnly
  case hidden
}

class NavigationThemer: UIViewController {
    var navbarThemeConfiguration: NavbarThemeConfiguration?
    var rightButtonTap = PassthroughSubject<Void, Never>()
    var leftButtonTap = PassthroughSubject<Void, Never>()
 
  // MARK: - Initializers -

  init(navbarThemeConfiguration: NavbarThemeConfiguration? = nil) {
    self.navbarThemeConfiguration = navbarThemeConfiguration
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - View Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    if let config = navbarThemeConfiguration {
      setupNavbar(with: config)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    if let config = navbarThemeConfiguration {
      setupNavbar(with: config)
    }
  }

  // MARK: - Navbar swapping -

  override func willMove(toParent _: UIViewController?) {
     guard let viewControllers = navigationController?.viewControllers,
              viewControllers.count > 1
    else { return }
     let previousViewController = viewControllers[viewControllers.count - 2]
    
    guard let config = previousViewController.navbarThemeConfiguration else { return }
    setupNavbar(with: config)
    
  }

  // MARK: - Navbar setup -

  private func setupNavbar(with config: NavbarThemeConfiguration) {
    setNavigationBar(style: config.navigationBarStyle,
                     title: config.title,
                     tintColor: config.tintColor,
                     barColor: config.barColor)
  }

    private func setNavigationBarAttributedTitle(title: String, color: UIColor = .black) {
       let navigationBarLabel = UILabel()
       let navigationBarTitle = NSMutableAttributedString(string: title, attributes: [
         NSAttributedString.Key.foregroundColor: color,
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)
       ])

       navigationBarLabel.attributedText = navigationBarTitle
       navigationItem.titleView = navigationBarLabel
     }
   

  func setRightButtonAction(with action: @escaping () -> Void) {
    navbarThemeConfiguration?.rightBtnAction = action
  }

  func baseStyle() {
    removeBackIndicator()
    setBaseConfig()
    setIsTranslucent(isTranslucent: false)
  }

  private func setNavigationBar(style navigationBarStyle: NavigationControllerStyle,
                                title: String? = nil,
                                tintColor: UIColor = .black,
                                barColor: UIColor = .white) {
    self.baseStyle()
    if let title = title {
      setNavigationBarAttributedTitle(title: title, color: tintColor)
    }
    navigationController?.navigationBar.tintColor = tintColor
    navigationController?.navigationBar.barTintColor = barColor

    switch navigationBarStyle {
    case .withBackButton:
      setBackIndicatorImage()
    
    case .titleOnly:
      removeBackIndicator()
        
    case .hidden:
      hideBar()
        
    case .cancelOnly:
      removeBackIndicator()
      setRightCancelButton()
        
    case .withBackButtonAndCancelButton:
      setBackIndicatorImage()
      setRightCancelButton()

    }
  }
}

extension NavigationThemer {
  @objc func onRightButtonPressed() {
    if let onPress = navbarThemeConfiguration?.rightBtnAction {
      onPress()
    }
  }

  @objc func navigateBack() {
    navigationController?.popViewController(animated: true)
  }

  @objc func popDismissController() {
    navigationController?.popToRootViewController(animated: false)
    dismiss(animated: false, completion: nil)
  }

  @objc func dismissNavigationController() {
    navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
  }

  private func setBaseConfig() {
    cleanBar()
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.shadowImage = UIImage()
  }

  private func cleanBar() {
    navigationController?.navigationBar.barTintColor = .clear
    navigationItem.hidesBackButton = true
    navigationItem.backBarButtonItem = nil
    navigationItem.rightBarButtonItem = nil
    navigationItem.leftBarButtonItem = nil
  }

  private func hideBar() {
    navigationController?.navigationBar.barTintColor = .clear
    navigationItem.hidesBackButton = true
    navigationItem.backBarButtonItem = nil
    navigationItem.rightBarButtonItem = nil
    navigationItem.leftBarButtonItem = nil
    navigationController?.setToolbarHidden(true, animated: false)
  }

  private func getRightButton() -> UIBarButtonItem? {
    return navigationItem.rightBarButtonItem
  }

  private func setIsTranslucent(isTranslucent: Bool) {
    navigationController?.navigationBar.isTranslucent = isTranslucent
  }

  private func setBackIndicatorImage(imageName: String = "left_arrow") {
    let img = UIImage(named: imageName)?.resize(scaledToSize: CGSize(width: 40, height: 40))

    let leftButton = UIButton(type: .system)
    leftButton.setImage(img, for: .normal)
    leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    leftButton.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)

    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
  }

  private func removeBackIndicator() {
    navigationItem.leftBarButtonItem = nil
    navigationItem.hidesBackButton = true
  }

  private func setRightCancelButton(_ color: UIColor = .black) {
    let image = UIImage(named: "icn_close")?
      .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)

    let rightButton = UIButton(type: .system)
    rightButton.setImage(image, for: .normal)
    rightButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    rightButton.tintColor = color
    rightButton.addTarget(self, action: #selector(dismissNavigationController), for: .touchUpInside)

    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
  }

//  private func setRightButton(message: String = "global_conditions".localized(),
//                              and color: UIColor) -> Driver<Void> {
//    let rightButton = UIBarButtonItem(title: message,
//                                      style: UIBarButtonItem.Style.plain,
//                                      target: self,
//                                      action: #selector(onRightButtonPressed))
//
//    let attributes = [NSAttributedString.Key.font:
//      UIFont(name: Constants.Fonts.CircularBook,
//             size: color == .darkCoral ? 16 : 13.7)!,
//                      NSAttributedString.Key.foregroundColor: color]
//
//    let buttonTap = rightButton.rx.tap.asDriver().mapToVoid()
//    rightButton.setTitleTextAttributes(attributes, for: .normal)
//    rightButton.setTitleTextAttributes(attributes, for: .selected)
//    navigationItem.rightBarButtonItem = rightButton
//
//    return buttonTap
//  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
  /// Custom back buttons disable the interactive pop animation
  /// To enable it back we set the recognizer to `self`
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}


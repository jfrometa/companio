//
//  FormView.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import MaterialComponents
import UIKit

class FormView: UIView {
  let tableView = UITableView(frame: .zero, style: .grouped)
  let btnContinue: MDCButton = {
    let button = MDCButton()
    button.setTitle("Continue", for: .normal)
    return button
  }()

  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    self.setView()
    self.setConstraints()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setView() {
    self.backgroundColor = .white
    
    self.tableView.backgroundColor = .white
    self.tableView.separatorStyle = .none
    self.tableView.register(TextFieldCellView.self,
                         forCellReuseIdentifier: TextFieldCellView.reuseID)
    self.tableView.allowsSelection = false
    self.tableView.bounces = true

    self.addSubview(self.tableView)
    self.addSubview(self.btnContinue)
    
    self.tableView.backgroundColor = .red
    self.btnContinue.backgroundColor = .blue
  }
    
    private func setConstraints() {
        self.tableView.constrain(top: topAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: 0, left: 20, bottom: 20, right: 20))

        self.btnContinue.constrain(top: tableView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: 0, left: 20, bottom: 10, right: 20))
      }
}


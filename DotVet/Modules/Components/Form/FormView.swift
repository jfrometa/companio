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
    let tableView = UITableView(frame: .zero, style: .grouped).withAutoLayout()
    let btnContinue: MDCButton = {
        let button = MDCButton().withAutoLayout()
        button.setTitle("Continue", for: .normal)
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        backgroundColor = .white
        let data = TitleAndMessage(title: "Header Title", message: "Message")
        let tableViewHeader = FormTableViewHeaderView(data: data)

        tableView.tableHeaderView = tableViewHeader
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TextFieldCellView.self,
                           forCellReuseIdentifier: TextFieldCellView.reuseID)
        tableView.allowsSelection = false
        tableView.bounces = true

        addSubview(tableView)
        addSubview(btnContinue)
    }

    private func setConstraints() {
        tableView.constrain(top: topAnchor,
                            leading: leadingAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))

        btnContinue.constrain(top: tableView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: 0, left: 20, bottom: 10, right: 20),
                              size: .init(width: 0, height: 48))
    }
}

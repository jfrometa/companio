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
    let tableViewHeader: FormTableViewHeaderView  = {
       let  data = TitleAndMessage(title: "Add Pet!", message: "Whats your pets name?")
       let header = FormTableViewHeaderView(data: data).withAutoLayout()
       return header
    }()
    let btnContinue: MDCButton = {
        let button = MDCButton().withAutoLayout()
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
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.register(TextFieldCellView.self,
                           forCellReuseIdentifier: TextFieldCellView.reuseID)
        self.tableView.allowsSelection = false
        self.tableView.bounces = true

        self.addSubview(tableView)
        self.addSubview(btnContinue)
        self.addSubview(tableViewHeader)
    }

    private func setConstraints() {
        self.tableViewHeader
            .constrain(top: safeTopAnchor,
                     leading: leadingAnchor,
                     trailing: trailingAnchor)
        
        self.tableView
            .constrain(top: tableViewHeader.safeAreaLayoutGuide.bottomAnchor,
                    leading: leadingAnchor,
                    trailing: trailingAnchor,
                    padding: .init(top: 0, left: 0, bottom: 0, right: 0))
   
        self.btnContinue
            .constrain(top: tableView.bottomAnchor,
                      leading: leadingAnchor,
                      bottom: safeBottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 0, left: 20, bottom: 5, right: 20),
                      size: .init(width: 0, height: 48))
    }
}

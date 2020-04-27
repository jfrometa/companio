//
//  FormDataSource.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

 protocol DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    associatedtype Values: TableViewSectionModelType
    var values: [Values] { get }
 }

 class FormViewDataSource: NSObject, DataSource {
    typealias Values = FormTextFieldSectionModel
    var values = [Values]()

    init(with fields: [Values] = []) {
        values.append(contentsOf: fields)
    }

    func update(_ rows: [Values]) {
        self.values = rows
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        values[section].items.count
    }

    func numberOfSections(in _: UITableView) -> Int {
        values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(
            withIdentifier: TextFieldCellView.reuseID, for: indexPath
        ) as? TextFieldCellView
        else {
            return UITableViewCell(frame: .zero)
        }

        let section = indexPath.section
        let index = indexPath.item

        cell.bind(viewModel: values[section].items[index])
        return cell
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TitleLabelView(message: values[section].header)
    }
 }

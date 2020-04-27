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
    
  init(with fields: [Values]){
     self.values = fields
  }
    
  func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.values[section].items.count
  }

  func numberOfSections(in _: UITableView) -> Int { values.count }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard values.count > 0, let cell = tableView.dequeueReusableCell(
      withIdentifier: TextFieldCellView.reuseID, for: indexPath
    ) as? TextFieldCellView
    else {
      return UITableViewCell(frame: .zero)
    }

    let section = indexPath.section
    let index = indexPath.item

    cell.viewModel = values[section].items[index]
    return cell
  }
    
}

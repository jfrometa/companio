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
    
  init(with fields: [Values] = []){
    self.values.append(contentsOf: fields)
  }
    
    func update(_ rows: [Values]){
        self.values.append(contentsOf: rows)
        
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

    cell.bind(viewModel: values[section].items[index])
    return cell
  }
    
    
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      guard values.count > 0 else { return UIView(frame: .zero) }
      return TitleLabelView(message: values[section].header)
    }
    
}

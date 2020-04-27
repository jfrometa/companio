//
//  TextFieldSectionModel.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

protocol TableViewSectionModelType {
    associatedtype Item
    init(header: String, items: [Item])

    var header: String { get }
    var items: [Item] { get }
}

struct FormTextFieldSectionModel: TableViewSectionModelType {
    typealias Item = TextFieldCellViewModel

    var header: String
    var items: [Item]
}

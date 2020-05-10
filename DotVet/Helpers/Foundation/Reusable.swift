//
//  Reusable.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UIViewController: Reusable {}
extension UITableView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self,
                                at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                             for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}

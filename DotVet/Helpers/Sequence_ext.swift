//
//  Sequence_ext.swift
//  DotVet
//
//  Created by Jose Frometa on 4/26/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
  func unique() -> [Iterator.Element] {
    var seen: [Iterator.Element: Bool] = [:]
    return filter { seen.updateValue(true, forKey: $0) == nil }
  }
}

//
//  SchemeProtocol.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

protocol Scheme {
    var date: String { get set }
    var nextDate: String { get set }
    var veterinary: String { get set }
    var values: String { get set }
    var prescription: String { get set }
    var picture: String { get set }
}

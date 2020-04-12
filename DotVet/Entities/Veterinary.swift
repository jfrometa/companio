//
//  Veterinary.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

protocol Vet: Person {
    var veterinary: Veterinary { get }
}

protocol Veterinary {
    var name: String { get }
    var address: String { get }
}

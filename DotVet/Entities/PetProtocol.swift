//
//  PetProtocol.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

protocol Pet {
    var name: String { get }
    var race: String? { get }
    var birthDate: String? { get }
    var address: String? { get }
    var owners: [String]? { get }
    var picture: String? { get }
    var weight: String? { get }
}

struct Dog: Pet {
    init(name: String) {
        self.name = name
    }

    var name: String
    var race: String?
    var birthDate: String?
    var address: String?
    var owners: [String]?
    var picture: String?
    var weight: String?
}

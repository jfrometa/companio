//
//  RegistryProtocol.swift
//  DotVet
//
//  Created by Jose Frometa on 4/10/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import Foundation

protocol RegistryProtocol {
    var veterinay: Veterinary? { get }
    var pet: Pet { get }
    var owners: [Owner] { get }
    var schemes: [Scheme] { get }
}

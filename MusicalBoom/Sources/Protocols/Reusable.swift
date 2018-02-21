//
//  Reusable.swift
//  MusicalBoom
//
//  Created by mac on 21.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

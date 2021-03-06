//
//  AlbumRequest.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct AlbumRequest: APIRequest {
    private let id: Int
    init(id: Int) {
        self.id = id
    }
    var path: String { return "/releases/\(id)" }
}

//
//  SearchRequest.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct SearchRequest: APIRequest {
    private let name: String
    init(name: String) {
        self.name = name
    }
    var path: String { return "/database/search" }
    var query: [String : APIQueryParameter] {
        return ["q" : .string(name),
                "type" : .string("artist")
        ]
    }
}


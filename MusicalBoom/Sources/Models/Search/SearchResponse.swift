//
//  SearchResponse.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let pagination: SearchPagination?
    let results: [SearchArtist]
}

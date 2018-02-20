//
//  ArtistInfo.swift
//  MusicalBoom
//
//  Created by mac on 19.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    let name: String
    let profile: String?
    let images: [ArtistImage]
}

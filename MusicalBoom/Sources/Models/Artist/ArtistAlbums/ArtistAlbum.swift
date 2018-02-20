//
//  ArtistAlbum.swift
//  MusicalBoom
//
//  Created by mac on 19.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct ArtistAlbum: Codable {
    let id: Int
    let title: String
    let year: Int?
    let thumb: String?
}

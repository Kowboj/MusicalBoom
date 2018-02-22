//
//  AlbumInfo.swift
//  MusicalBoom
//
//  Created by mac on 22.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct AlbumInfo: Codable {
    let id: Int
    let title: String?
    let notes: String?
    let year: Int?
    let tracklist: [AlbumTrack]
    let images: [AlbumImage]?
}

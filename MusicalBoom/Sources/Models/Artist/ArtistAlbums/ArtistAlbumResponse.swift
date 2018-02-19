//
//  ArtistAlbumResponse.swift
//  MusicalBoom
//
//  Created by mac on 19.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct ArtistAlbumResponse: Codable {
    let pagination: ArtistAlbumPagination
    let releases: [ArtistAlbum]
}

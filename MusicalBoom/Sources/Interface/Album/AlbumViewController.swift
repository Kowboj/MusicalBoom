//
//  AlbumViewController.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class AlbumViewController: ViewController {
    
    private let albumView = AlbumView()
    private let release_id = 1
    
    override func loadView() {
        super.loadView()
        view = albumView
    }
}

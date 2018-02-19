//
//  ArtistCell.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class ArtistCell: TableViewCell {
    
    lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViewHierarchy() {
        contentView.addSubview(albumLabel)
    }
    
    override func setupProperties() {
        backgroundColor = UIColor.white
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            albumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            albumLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

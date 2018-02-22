//
//  AlbumCell.swift
//  MusicalBoom
//
//  Created by mac on 22.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class AlbumCell: TableViewCell {
    
    lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "AmericanTypewriter", size: 15)
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AmericanTypewriter", size: 15)
        return label
    }()
    
    override func setupViewHierarchy() {
        contentView.addSubview(trackLabel)
        contentView.addSubview(durationLabel)
    }
    
    override func setupProperties() {
        backgroundColor = UIColor.darkGray
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            trackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            trackLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            durationLabel.leadingAnchor.constraint(equalTo: trackLabel.trailingAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            durationLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

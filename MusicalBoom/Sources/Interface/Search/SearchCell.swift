//
//  SearchCell.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class SearchCell: TableViewCell {
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "AmericanTypewriter", size: 15)
        return label
    }()
    
    override func setupViewHierarchy() {
        contentView.addSubview(artistNameLabel)
    }
    
    override func setupProperties() {
        backgroundColor = .white
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
    }
}

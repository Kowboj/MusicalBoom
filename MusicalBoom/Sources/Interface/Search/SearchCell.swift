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
        return label
    }()
    
    override func setupViewHierarchy() {
        contentView.addSubview(artistNameLabel)
    }
    
    override func setupProperties() {
        backgroundColor = UIColor.white
    }
    
    override func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}

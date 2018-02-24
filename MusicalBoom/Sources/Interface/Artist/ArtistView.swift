//
//  ArtistView.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class ArtistView: View {
    
    lazy var artistInfo: UITextView = {
        let artistInfo = UITextView()
        artistInfo.backgroundColor = .lightGray
        artistInfo.dataDetectorTypes = .all
        artistInfo.translatesAutoresizingMaskIntoConstraints = false
        artistInfo.font = UIFont(name: "AmericanTypewriter", size: 14)
        return artistInfo
    }()
    
    lazy var artistPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [artistInfo, artistPhoto, tableView].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        NSLayoutConstraint.activate([
            artistPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            artistPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 76),
            artistPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            artistInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            artistInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            artistInfo.topAnchor.constraint(equalTo: artistPhoto.bottomAnchor, constant: 20),
            artistInfo.heightAnchor.constraint(equalToConstant: 120),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: artistInfo.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ])
    }
}

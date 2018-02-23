//
//  AlbumView.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class AlbumView: View {
    
    var albumInfo: UILabel = {
        let albumInfo = UILabel()
        albumInfo.translatesAutoresizingMaskIntoConstraints = false
        albumInfo.font = UIFont(name: "AmericanTypewriter", size: 12)
        albumInfo.adjustsFontSizeToFitWidth = true
        albumInfo.numberOfLines = 16
        return albumInfo
    }()
    
    var albumYear: UILabel = {
        let albumYear = UILabel()
        albumYear.translatesAutoresizingMaskIntoConstraints = false
        albumYear.font = UIFont(name: "AmericanTypewriter", size: 15)
        albumYear.textAlignment = NSTextAlignment.center
        return albumYear
    }()
    
    var albumPhoto: UIImageView = {
        let albumPhoto = UIImageView()
        albumPhoto.translatesAutoresizingMaskIntoConstraints = false
        albumPhoto.contentMode = .scaleAspectFit
        return albumPhoto
    }()
    
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func setupProperties() {
        super.setupProperties()
    }
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [albumInfo, albumYear, albumPhoto, tableView].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        NSLayoutConstraint.activate([
            albumPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            albumPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            albumPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            albumInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            albumInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            albumInfo.topAnchor.constraint(equalTo: albumYear.bottomAnchor, constant: 20),
            albumInfo.heightAnchor.constraint(equalToConstant: 100),
            
            albumYear.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            albumYear.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            albumYear.topAnchor.constraint(equalTo: albumPhoto.bottomAnchor, constant: 20),
            albumYear.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: albumInfo.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ])
    }
}


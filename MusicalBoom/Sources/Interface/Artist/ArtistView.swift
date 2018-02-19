//
//  ArtistView.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class ArtistView: View {
    
    var artistName: UILabel = {
        let artistName = UILabel()
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    var activeFrom: UILabel = {
        let activeFrom = UILabel()
        activeFrom.translatesAutoresizingMaskIntoConstraints = false
        return activeFrom
    }()
    
    var artistInfo: UILabel = {
        let artistInfo = UILabel()
        artistInfo.translatesAutoresizingMaskIntoConstraints = false
        return artistInfo
    }()
    
    var artistPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorStyle = .none
        //        tableView.keyboardDismissMode = .onDrag
        //        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    
    override func setupProperties() {
        super.setupProperties()
        
    }
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [artistName, activeFrom, artistInfo, artistPhoto, tableView].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        NSLayoutConstraint.activate([
            artistPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            artistPhoto.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            artistPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            artistPhoto.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            artistName.leadingAnchor.constraint(equalTo: artistPhoto.trailingAnchor, constant: 20),
            artistName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            artistName.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            artistName.heightAnchor.constraint(equalToConstant: 44),
            
            activeFrom.leadingAnchor.constraint(equalTo: artistPhoto.trailingAnchor, constant: 20),
            activeFrom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            activeFrom.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 20),
            activeFrom.heightAnchor.constraint(equalToConstant: 44),
            
            artistInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            artistInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            artistInfo.topAnchor.constraint(equalTo: artistPhoto.bottomAnchor, constant: 20),
            artistInfo.heightAnchor.constraint(equalToConstant: 120),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: artistInfo.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

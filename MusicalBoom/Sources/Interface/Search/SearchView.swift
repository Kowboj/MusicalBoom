//
//  SearchView.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class SearchView: View {
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.darkGray
        searchBar.placeholder = "Find an artist..."
        return searchBar
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
        [searchBar, tableView].forEach(addSubview)
    }
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
            ])
    }
}



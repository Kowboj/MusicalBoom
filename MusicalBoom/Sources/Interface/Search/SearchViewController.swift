//
//  SearchViewController.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class SearchViewController: ViewController, UISearchBarDelegate {
    
    private let searchView = SearchView()
    private let apiClient = DefaultAPIClient()
    private var searchResponse: SearchResponse?
    private var searchArtists : [SearchArtist] = []
    
    
    override func loadView() {
        view = searchView
    }

    override func setupNavigationItem() {
        super.setupNavigationItem()
        navigationItem.title = "MusicalBoom"
    }
    
    override func setupProperties() {
        super.setupProperties()
        searchView.tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let searchBarText = searchBar.text else { return }
        getArtists(name: searchBarText) { artist in
            self.searchArtists.removeAll()
            self.searchArtists.append(contentsOf: artist)
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    func getArtists(name: String, completion: @escaping ([SearchArtist]) -> Void) {
        
        apiClient.send(request: SearchRequest(name: name)) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(SearchResponse.self, from: data)
                    self.searchResponse = model
                    completion(model.results)
                } catch let jsonErr {
                    print(jsonErr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistViewController = ArtistViewController(artistId: searchArtists[indexPath.row].id)
        navigationController?.pushViewController(artistViewController, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier) as? SearchCell {
            let currentItem = searchArtists[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.artistNameLabel.text = currentItem.title
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

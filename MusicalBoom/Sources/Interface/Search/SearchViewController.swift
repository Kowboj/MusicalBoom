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
    private let token = "ruDboTcLUPhRJTvKzOjfIhdWAJmXCtnJSpEvnjet"
    private var searchResponse: SearchResponse?
    private var searchArtists : [SearchArtist] = []
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationItem() {
        navigationItem.title = "MusicalBoom"
    }
    
    override func setupProperties() {
        searchView.tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let searchBarText = searchBar.text else { return }
        searchArtists.removeAll()
        getArtists(name: searchBarText, token: token) {artist in
            self.searchArtists.append(contentsOf: artist)
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    func getArtists(name: String, token: String, completion: @escaping ([SearchArtist]) -> Void) {
            
            let urlString = "https://api.discogs.com/database/search?q=\(name)&type=artist&token=\(token)"
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let model = try JSONDecoder().decode(SearchResponse.self, from: data)
                    self.searchResponse = model
                    completion(model.results)
                } catch let jsonErr {
                    print(jsonErr)
                }
                }.resume()
            
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
            cell.artistNameLabel.text = currentItem.title
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//
//  ArtistViewController.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class ArtistViewController: ViewController {
    
    private let artistView = ArtistView()
    private let cellId = "cellId"
    private let token = "ruDboTcLUPhRJTvKzOjfIhdWAJmXCtnJSpEvnjet"
    private let artistId: Int
    private var artistAlbums: [ArtistAlbum] = []
    
    init(artistId: Int) {
        self.artistId = artistId
        super.init()
    }
    
    override func loadView() {
        view = artistView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePage()
        updateAlbums()
    }
    
    
    private func updatePage(){
        getArtistInfo(id: artistId, token: token) { [unowned self] artist in
            DispatchQueue.main.async {
                self.artistView.artistInfo.text = artist.profile
                self.navigationItem.title = artist.name
                
                guard let artistPhoto = artist.images?.first?.resource_url else { return }
                self.getArtistPhoto(artistPhotoUrl: artistPhoto) { [unowned self] photo in
                    DispatchQueue.main.async {
                        self.artistView.artistPhoto.image = photo
                    }
                }
            }
        }
    }
    
    private func updateAlbums(){
        getArtistAlbums(id: artistId, token: token) { [unowned self] albums in
            
            DispatchQueue.main.async {
                self.artistAlbums.removeAll()
                self.artistAlbums.append(contentsOf: albums)
                self.artistView.tableView.reloadData()
            }
        }
    }
    
    override func setupProperties() {
        artistView.tableView.register(ArtistCell.self, forCellReuseIdentifier: cellId)
        artistView.tableView.dataSource = self
        artistView.tableView.delegate = self
    }
    
    func getArtistPhoto(artistPhotoUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: artistPhotoUrl) else { return }
        do {
            let imageData = try Data(contentsOf: url as URL)
            let photo = UIImage(data: imageData)
            completion(photo)
        }
        catch _ {
            completion(nil)
        }
    }
    
    func getArtistAlbums(id: Int, token: String, completion: @escaping ([ArtistAlbum]) -> Void) {
        
        let urlString = "https://api.discogs.com/artists/\(id)/releases"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        let headerValue = "Discogs token=\(token)"
        urlRequest.setValue(headerValue, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(ArtistAlbumResponse.self, from: data)
                completion(model.releases)
            } catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
        
        
    }
    
    func getArtistInfo(id: Int, token: String, completion: @escaping (ArtistInfo) -> Void) {
        
        let urlString = "https://api.discogs.com/artists/\(id)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        let headerValue = "Discogs token=\(token)"
        urlRequest.setValue(headerValue, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(ArtistInfo.self, from: data)
                completion(model)
            } catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Albums"
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView
//    }
}

extension ArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController = AlbumViewController()
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}

extension ArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistAlbums.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ArtistCell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ArtistCell {
            let currentItem = artistAlbums[indexPath.row]
            cell.albumLabel.text = currentItem.title
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

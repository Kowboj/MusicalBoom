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
    
    private var artistInfo: ArtistInfo?
    private var artistAlbumResponse: ArtistAlbumResponse?
    private var artistAlbums: [ArtistAlbum] = []
    private var artistPhotoImage: UIImage?
    
    var currentId = 1
    

    override func loadView() {
        super.loadView()
        view = artistView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArtistInfo(id: currentId, token: token) {artist in
            self.artistInfo = artist
            DispatchQueue.main.async {
                print(self.artistInfo!)
                self.artistView.artistName.text = self.artistInfo?.name
                self.artistView.artistInfo.text = self.artistInfo?.profile
                self.navigationItem.title = "\(self.artistInfo?.name)"
            }
        }
        getArtistAlbums(id: currentId, token: token) {album in
            self.artistAlbums.append(contentsOf: album)
            DispatchQueue.main.async {
                self.artistView.tableView.reloadData()
            }
        }
        
        guard let artistPhoto = artistInfo?.images![0].resource_url else { return }
        do {
            getArtistPhoto(artistPhotoUrl: artistPhoto) {photo in
            self.artistPhotoImage = photo
            DispatchQueue.main.async {
                self.artistView.artistPhoto.image = self.artistPhotoImage
            }
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
        catch let photoErr {
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
                self.artistAlbumResponse = model
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
                self.artistInfo = model
                completion(model)
            } catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let albumViewController = AlbumViewController()
        navigationController?.pushViewController(albumViewController, animated: true)
    }
    
}

extension ArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (artistAlbums.count)
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

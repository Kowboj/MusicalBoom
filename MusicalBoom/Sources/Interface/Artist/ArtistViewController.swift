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
    private let artistId: Int
    private let apiClient = DefaultAPIClient()
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
        getArtistInfo(id: artistId) { [unowned self] artist in
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
        getArtistAlbums(id: artistId) { [unowned self] albums in
            
            DispatchQueue.main.async {
                self.artistAlbums.removeAll()
                self.artistAlbums.append(contentsOf: albums)
                self.artistView.tableView.reloadData()
            }
        }
    }
    
    override func setupProperties() {
        super.setupProperties()
        artistView.tableView.register(ArtistCell.self, forCellReuseIdentifier: ArtistCell.reuseIdentifier)
        artistView.tableView.dataSource = self
        artistView.tableView.delegate = self
    }
    
    private func getArtistPhoto(artistPhotoUrl: String, completion: @escaping (UIImage?) -> Void) {
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
    
    private func getArtistAlbums(id: Int, completion: @escaping ([ArtistAlbum]) -> Void) {
        
        apiClient.send(request: ArtistAlbumsRequest(id: id)) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ArtistAlbumResponse.self, from: data)
                    completion(model.releases)
                } catch let jsonErr {
                    print(jsonErr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getArtistInfo(id: Int, completion: @escaping (ArtistInfo) -> Void) {
        
        apiClient.send(request: ArtistRequest(id: id)) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(ArtistInfo.self, from: data)
                    completion(model)
                } catch let jsonErr {
                    print(jsonErr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Albums"
    }
}

extension ArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController = AlbumViewController(albumId: artistAlbums[indexPath.row].id)
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}

extension ArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistAlbums.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ArtistCell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.reuseIdentifier) as? ArtistCell {
            let currentItem = artistAlbums[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.albumLabel.text = currentItem.title
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

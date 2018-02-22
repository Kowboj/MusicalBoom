//
//  AlbumViewController.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

final class AlbumViewController: ViewController {
    
    private let albumView = AlbumView()
    private let token = "ruDboTcLUPhRJTvKzOjfIhdWAJmXCtnJSpEvnjet"
    private let albumId : Int
    private var albumTracks: [AlbumTrack] = []
    
    init(albumId: Int) {
        self.albumId = albumId
        super.init()
    }
    override func loadView() {
        view = albumView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePage()
    }
    
    private func updatePage() {
        getAlbumInfo(id: albumId, token: token) { [unowned self] album in
            DispatchQueue.main.async {
                
                self.albumView.albumInfo.text = album.notes
                self.albumView.albumYear.text = String(describing: album.year!)
                self.navigationItem.title = album.title
                self.albumTracks.removeAll()
                self.albumTracks.append(contentsOf: album.tracklist)
                self.albumView.tableView.reloadData()
                
                guard let albumPhoto = album.images?.first?.resource_url else { return }
                self.getAlbumPhoto(albumPhotoUrl: albumPhoto) { [unowned self] photo in
                    DispatchQueue.main.async {
                        self.albumView.albumPhoto.image = photo
                    }
                }
            }
        }
    }
    
    private func getAlbumInfo(id: Int, token: String, completion: @escaping (AlbumInfo) -> Void) {
        
        let urlString = "https://api.discogs.com/releases/\(id)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        let headerValue = "Discogs token=\(token)"
        urlRequest.setValue(headerValue, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(AlbumInfo.self, from: data)
                completion(model)
            } catch let jsonErr {
                print(jsonErr)
            }
            }.resume()
    }
    
    private func getAlbumPhoto(albumPhotoUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: albumPhotoUrl) else { return }
        do {
            let imageData = try Data(contentsOf: url as URL)
            let photo = UIImage(data: imageData)
            completion(photo)
        }
        catch _ {
            completion(nil)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tracks"
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView
//    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumTracks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: AlbumCell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier) as? AlbumCell {
            let currentItem = albumTracks[indexPath.row]
            cell.trackLabel.text = currentItem.title
            cell.durationLabel.text = currentItem.duration
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


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
    private let albumId: Int
    private let apiClient = DefaultAPIClient()
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
        getAlbumInfo(id: albumId) { [unowned self] album in
            self.albumTracks.removeAll()
            self.albumTracks.append(contentsOf: album.tracklist)
            DispatchQueue.main.async {
                self.albumView.tableView.reloadData()
                self.albumView.albumInfo.text = album.notes
                self.albumView.albumYear.text = String(describing: album.year!)
                self.navigationItem.title = album.title
                
                guard let albumPhoto = album.images?.first?.resource_url else { return }
                self.getAlbumPhoto(albumPhotoUrl: albumPhoto) { [unowned self] photo in
                    DispatchQueue.main.async {
                        self.albumView.albumPhoto.image = photo
                    }
                }
            }
        }
    }
    
    override func setupProperties() {
        super.setupProperties()
        albumView.tableView.delegate = self
        albumView.tableView.dataSource = self
        albumView.tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.reuseIdentifier)
    }
    
    private func getAlbumInfo(id: Int, completion: @escaping (AlbumInfo) -> Void) {
        
        apiClient.send(request: AlbumRequest(id: id)) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(AlbumInfo.self, from: data)
                    completion(model)
                } catch let jsonErr {
                    print(jsonErr)
                }
            case .failure(let error):
                print(error)
            }
        }
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


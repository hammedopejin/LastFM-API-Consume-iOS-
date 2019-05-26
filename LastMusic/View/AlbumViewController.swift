//
//  AlbumViewController.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var albumTableView: UITableView!
    
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbum()
        
    }
    
    @objc func updateAlbums() {
        DispatchQueue.main.async {
            self.albumTableView.reloadData()
        }
    }
    
    
    func setupAlbum() {
        
        viewModel.getAlbums(by: viewModel.currentArtist)
        
        albumTableView.register(UINib(nibName: ContentTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ContentTableCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAlbums), name: Notification.Name.AlbumNotification, object: nil)
        
        albumTableView.tableFooterView = UIView(frame: .zero)
        
        albumTableView.dataSource = self
        albumTableView.delegate = self
    }

}

// MARK: table view

extension AlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Search", bundle: Bundle.main)
        let trackVC = storyboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        
        trackVC.viewModel = viewModel
        trackVC.position = indexPath.row
        
        present(trackVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        
        switch section {
        case 1:
            
            let label = UILabel()
            label.text = "\(viewModel.currentArtist.name) Albums"
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(label)
            containerView.backgroundColor = UIColor(white: 0.9, alpha: 1)
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? .zero : 25
    }
    
}

extension AlbumViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.identifier, for: indexPath) as! AlbumTableCell
            let artist = viewModel.currentArtist
            cell.configureTable(with: artist!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableCell.identifier, for: indexPath) as! ContentTableCell
            let album = viewModel.albums[indexPath.row]
            let content = Content.album(album)
            cell.configure(with: content)
            
            return cell
        }
       
    }
    
}

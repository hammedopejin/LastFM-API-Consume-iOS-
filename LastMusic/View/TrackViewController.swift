//
//  TrackViewController.swift
//  LastMusic
//
//  Created by mac on 5/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet weak var trackTableView: UITableView!
    @IBOutlet weak var trackCollectionView: UICollectionView!
    
    var viewModel: ViewModel!
    var position: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrack()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        trackCollectionView.scrollToItem(at: IndexPath(row: position, section: 0), at: .left, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Selector
    
    @objc func updateTracks() {
        DispatchQueue.main.async {
            self.trackTableView.reloadData()
            print("Reloaded Tracks TableView")
        }
    }
    
    //MARK: Setup

    func setupTrack() {
        trackTableView.register(UINib(nibName: ContentTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ContentTableCell.identifier)
        trackTableView.tableFooterView = UIView(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTracks), name: Notification.Name.TrackNotification, object: nil)
        viewModel.getTracks(by: viewModel.currentArtist)
    }

}


 //MARK: collection view

extension TrackViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 175, height: 193)
    }

}

extension TrackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionCell.identifier, for: indexPath) as! TrackCollectionCell

        let album = viewModel.albums[indexPath.row]
        cell.configure(with: album)

        return cell
    }


}

// MARK: table view

extension TrackViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView()
        
        let label = UILabel()
        label.text = "\(viewModel.currentArtist.name)'s Tracks"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        containerView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        return containerView
        
    }
    
}

extension TrackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableCell.identifier, for: indexPath) as! ContentTableCell
        
        cell.backgroundColor = .clear
        
        let track = viewModel.tracks[indexPath.row]
        let content = Content.track(track)
        cell.configure(with: content)

        return cell
    }


}

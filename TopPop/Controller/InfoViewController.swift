//
//  InfoViewController.swift
//  TopPop
//
//  Created by Zeljko halle on 22/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var song: Song?
    
    var anotherSongsNames = [String]()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAuthorLabel: UILabel!
    @IBOutlet weak var songCoverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureViews()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func configureViews() {
        songNameLabel.font = UIFont.boldSystemFont(ofSize: songNameLabel.font.pointSize)
        albumNameLabel.font = UIFont.boldSystemFont(ofSize: albumNameLabel.font.pointSize)
        songCoverImageView.contentMode = .scaleAspectFill
        
        if let song = song {
            songNameLabel.text = song.songName
            songAuthorLabel.text = song.author
            
            AppService.shared.getAlbumInfo(albumID: song.albumID) { (coverURLString, albumName, albumSongs) in
                self.albumNameLabel.text = albumName
                self.anotherSongsNames = albumSongs
                
                // ako u albumu ostalih pjesama ima 1 pjesma i ako se ta jedna zove isto kao i pjesma koju sam stisnuo to znaci da taj album ne postoji vec je samo tako spremljen u bazi
                // zato sakrijem tableview jer nam ne treba
                if self.anotherSongsNames.count == 1 && self.anotherSongsNames[0] == song.songName {
                    self.tableView.isHidden = true
                    self.albumNameLabel.text = "This song is a single"
                } else {
                    //makni iz liste ostalih pjesama iz albuma ovu koju trenutno gledam
                    self.anotherSongsNames.remove(at: self.anotherSongsNames.firstIndex(of: song.songName)!)
                    self.tableView.reloadData()
                }
                
                let imageURL = URL(string: coverURLString)
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL!)
                    DispatchQueue.main.async {
                        self.songCoverImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    

    //MARK: TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anotherSongsNames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SongTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SongTableViewCell else {
            fatalError()
        }
        
        cell.songNameLabel.text = anotherSongsNames[indexPath.row]
        return cell
    }

}

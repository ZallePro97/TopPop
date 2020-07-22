//
//  Chart.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class ChartTableViewController: UITableViewController {
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loadSongsIntoTable()
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func refresh(sender: AnyObject) {
        songs.removeAll()
        tableView.reloadData()
        loadSongsIntoTable()
        refreshControl?.endRefreshing()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem?.title = "Menu"
    }
    
    private func loadSongsIntoTable() {
        AppService.shared.getDeezerChart { (songsData) in
            self.songs = songsData
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    // bez ovoga visina celije je i dalje ista, makar je promjenjena u IB
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellIdentifier = "ChartTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ChartTableViewCell else {
            fatalError("Cannot cast UICell to ChartTableViewCell")
        }
        
        return cell.bounds.size.height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ChartTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChartTableViewCell else {
            fatalError("Cannot cast UICell to ChartTableViewCell")
        }
        
        let song = songs[indexPath.row]
        
        cell.rankView.rankLabel.text = String(song.rank)
        cell.songNameLabel.text = song.songName
        cell.songAuthorLabel.text = song.author
        cell.songDurationLabel.text = DataUtil.fromSecondsToMMSSString(duration: song.duration)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedRow = tableView.indexPathForSelectedRow?.row {
            if let destinationVC = segue.destination as? InfoViewController {
                destinationVC.song = songs[selectedRow]
            }
        }
    }
    
    @IBAction func unwindToChartTableViewController(segue: UIStoryboardSegue) {
        let source = segue.source as? MenuViewController
        
        if let option = source?.tappedOption {
            sortSongsByDuration(option: option)
        }
    }
    
    func sortSongsByDuration(option: Int) {
        switch option {
        case 0:
            songs.sort { (s1, s2) -> Bool in
                s1.rank < s2.rank
            }
            tableView.reloadData()
        case 1:
            songs.sort { (s1, s2) -> Bool in
                s1.duration < s2.duration
            }
            
            tableView.reloadData()
        case 2:
            songs.sort { (s1, s2) -> Bool in
                s1.duration > s2.duration
            }
            
            tableView.reloadData()
        default:
            fatalError()
        }
    }

}

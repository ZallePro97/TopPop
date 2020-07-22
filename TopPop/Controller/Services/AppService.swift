//
//  AppService.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import Foundation
import Alamofire

class AppService {
    
    private let connectionString: String = "https://api.deezer.com"
    
    static let shared = AppService()
    
    private init() {
        
    }
    
    func getDeezerChart(completion: @escaping (([Song]) -> Void)) {
        guard let url = URL(string: connectionString + "/chart") else {
            fatalError("Can't find anything on the connection string: \(connectionString)")
        }
        
        Alamofire
        .request(url, method: .get, parameters: nil)
        .validate()
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    print("Error while fetching songs chart: \(String(describing: response.result.error))")
                    return
                }
                
                guard let jsonResponse = response.result.value as? [String: Any] else {
                    return
                }
                
                var songs = [Song]()

                guard let tracks = jsonResponse["tracks"] as? [String: Any], let songsData = tracks["data"] as? NSArray else {
                    fatalError()
                }
                
                for songDict in songsData {
                    guard let songData = songDict as? [String: Any] else {
                        fatalError()
                    }
                    
                    guard let artistInfo = songData["artist"] as? [String: Any],
                        let albumInfo = songData["album"] as? [String: Any],
                        let songTitle = songData["title"] as? String,
                        let songRank = songData["position"] as? Int,
                        let songDuration = songData["duration"] as? Int else {
                            fatalError()
                    }
                    
                    guard let songAuthor = artistInfo["name"] as? String else {
                        fatalError()
                    }
                    
                    guard let albumID = albumInfo["id"] as? Int else {
                        fatalError()
                    }
                    
                    let song = Song(rank: songRank, songName: songTitle, author: songAuthor, duration: songDuration, albumID: albumID)
                    songs.append(song)
                }
                
                completion(songs)
        }
        
    }
    
    func getAlbumInfo(albumID: Int, completion: @escaping ((String, String, [String]) -> Void)) {
        let connString = connectionString + "/album/\(albumID)"
        
        guard let url = URL(string: connString) else {
            fatalError("Can't find anything on the connection string: \(connString)")
        }
        
        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    print("Error while fetching songs chart: \(String(describing: response.result.error))")
                    return
                }
                
                guard let jsonResponse = response.result.value as? [String: Any] else {
                    return
                }
                
                guard let coverURLString = jsonResponse["cover_big"] as? String, let albumName = jsonResponse["title"] as? String else {
                    fatalError()
                }
                
                guard let tracks = jsonResponse["tracks"] as? [String: Any] else {
                    fatalError()
                }
                
                guard let songsData = tracks["data"] as? NSArray else {
                    fatalError()
                }
                
                var songsNames = [String]()
                
                for songData in songsData {
                    if let songDict = songData as? [String: Any] {
                        guard let songName = songDict["title"] as? String else {
                            fatalError()
                        }
                        
                        songsNames.append(songName)
                    }
                }
                
                completion(coverURLString, albumName, songsNames)
        }
        
    }
    
}

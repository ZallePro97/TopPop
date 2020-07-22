//
//  Meal.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class Song: Codable {

    var rank: Int
    var songName: String
    var author: String
    var duration: Int
    var albumID: Int

    init(rank: Int, songName: String, author: String, duration: Int, albumID: Int) {
        self.rank = rank
        self.songName = songName
        self.author = author
        self.duration = duration
        self.albumID = albumID
    }
    
}

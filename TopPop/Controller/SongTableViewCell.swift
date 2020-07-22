//
//  SongTableViewCell.swift
//  TopPop
//
//  Created by Zeljko halle on 22/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        configureViews()
    }
    
    func configureViews() {
        print("eto me")
        songNameLabel.adjustsFontSizeToFitWidth = true
        songNameLabel.numberOfLines = 0
        songNameLabel.minimumScaleFactor = 0.5
    }

}

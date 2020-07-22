//
//  ChartTableViewCell.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var rankView: RankView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAuthorLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songNameLabel.font = UIFont.boldSystemFont(ofSize: songNameLabel.font.pointSize)
        songNameLabel.adjustsFontSizeToFitWidth = true
        songNameLabel.minimumScaleFactor = 0.2
        songAuthorLabel.adjustsFontSizeToFitWidth = true
        songAuthorLabel.minimumScaleFactor = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

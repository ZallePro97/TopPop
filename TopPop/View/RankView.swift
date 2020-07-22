//
//  Rank.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

@IBDesignable
class RankView: UIView {

    var rankLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        imageView = UIImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "blackCircle")
        addSubview(imageView)
        
        imageView.autoPinEdgesToSuperviewEdges()
        
        rankLabel = UILabel()
        rankLabel.text = "dada"
        imageView.addSubview(rankLabel)
        
        rankLabel.autoCenterInSuperview()
    }

}

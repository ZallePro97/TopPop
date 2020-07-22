//
//  MenuViewController.swift
//  TopPop
//
//  Created by Zeljko halle on 22/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var tappedOption: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton else {
            fatalError()
        }
        
        tappedOption = button.tag
        super.prepare(for: segue, sender: sender)
    }

}

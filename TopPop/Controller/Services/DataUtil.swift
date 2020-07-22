//
//  DataUtil.swift
//  TopPop
//
//  Created by Zeljko halle on 21/07/2020.
//  Copyright © 2020 Zeljko halle. All rights reserved.
//

import Foundation

class DataUtil {
    
    static func fromSecondsToMMSSString(duration seconds: Int) -> String {
        let mins: Int = seconds / 60
        let secs: Int = seconds - mins * 60
        
        return "\(mins):\(secs)"
    }
    
}

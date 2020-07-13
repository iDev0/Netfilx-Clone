//
//  utils.swift
//  Netfilx Clone
//
//  Created by iDev0 on 2020/07/12.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    public static let shared = Utils()
    
    func getImage(url: String) -> UIImage {
        let imageUrl = URL(string: url)
        let imageData = try! Data(contentsOf: imageUrl!)
        return UIImage(data: imageData)!
    }
}


//
//  NowPlayingCell.swift
//  Netfilx Clone
//
//  Created by iDev0 on 2020/07/12.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit

class NowPlayingCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  OtherTableViewCell.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/26/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class OtherTableViewCell: MessageTableViewCell {
    
    
    @IBOutlet var message: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//
//  MainTableViewCell.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/17/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    
    var isOn = false
    var numberOflikes : Int = 0
    
    @IBOutlet var timelineComment: UILabel!
    
    @IBOutlet var timelineProfileImage: UIImageView!
    
    @IBOutlet var timelineUsernameLabel: UILabel!
    
    @IBOutlet var timelineContentImage: UIImageView?
    
    @IBAction func likeButton(_ sender: Any) {
        

        likeLabel.isHidden = false
        
        
        if (numberOflikes == 1) {
            numberOflikes -= 1
        likeLabel.text = "\(numberOflikes) like"
        } else {
            numberOflikes += 1
            likeLabel.text = "\(numberOflikes) likes"
        }
    }
    
    @IBAction func commentButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
    
    @IBOutlet var likeLabel: UILabel!
    
    @IBOutlet var shareLabel: UILabel!
    
    @IBOutlet var timelineContentText: UILabel!
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        timelineContentImage?.kf.setImage(with: url)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CommentTableViewCell.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/22/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var TopUserImage: UIImageView!
    @IBOutlet var TopUserName: UILabel!
    @IBOutlet var TopUserComment: UILabel!
    @IBOutlet var ButtonReply: UIButton!
    @IBOutlet var ButtonViewReplies: UIButton!
    
    var replies: [CommentModel] = []
    var indexPath: IndexPath?
    
    func updateView(comment: CommentModel) {
        
        self.TopUserName.text = comment.name
        self.TopUserComment.text = comment.comment
        self.ButtonReply.tag = comment.id!
        
        if comment.replies.count > 0 {
            self.ButtonViewReplies.setTitle("__ View \(comment.replies.count) replies", for: .normal)
            self.ButtonViewReplies.isHidden = false
        } else {
            self.ButtonViewReplies.isHidden = true
        }
        
    }
    
 
    @IBAction func ButtonReplyPressed(_ sender: UIButton) {
    }
    
    @IBAction func ButtonViewRepliesPressed(_ sender: Any) {
        
        let data: [String:Any] = ["indexPath":self.indexPath!]
        NotificationCenter.default.post(name: NOTIF_VIEW_REPLIES_PRESSED, object: nil, userInfo: data)
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

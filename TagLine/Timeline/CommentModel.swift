//
//  CommentModel.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/22/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import Foundation
struct CommentModel {
    var name: String?
    var comment: String?
    var replies: [CommentModel] = []
    var isOpen = false
    var id: Int?
    init(name: String,comment: String, id: Int, replies: [CommentModel]) {
        self.name = name
        self.comment = comment
        self.id = id
        self.replies = replies
    }
}


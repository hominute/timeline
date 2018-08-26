//
//  DataList.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/22/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import Foundation
// Here is your data come from json or any other resource
class DataList {
    func getData() -> [CommentModel] {
        var comments: [CommentModel] = []
        comments.append(CommentModel(name: "MahdiMakhdumi", comment: "Hello, lets find how it works!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!asdfasdfasdfasdfasdfaasdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffsd", id: 1, replies: [CommentModel(name: "Kevin", comment: "That's cool", id: 1, replies: []),
                                                                                                                                                                                                                                                 CommentModel(name: "MahdiMakhdumi", comment: "@Kevin Thanks <3", id: 1, replies: [])]))
        comments.append(CommentModel(name: "SepehrHamzeloy", comment: "Greate tutorial", id: 2, replies: []))
        comments.append(CommentModel(name: "SpiderMan", comment: "I'm a superhero", id: 3, replies: []))
        comments.append(CommentModel(name: "TomHardy", comment: "Venom is comming", id: 4, replies: [CommentModel(name: "Tom", comment: "Finallyyyyyyyyyy <3", id: 4, replies: []),
                                                                                                     CommentModel(name: "Batman", comment: "I'm watching you :-)", id: 4, replies: [])]))
        comments.append(CommentModel(name: "SamWinchester", comment: "here is my comment from supernatrual series", id: 5, replies: []))
        comments.append(CommentModel(name: "DeanWinchester", comment: "Hey sami! wtf you doing here? lets kill monsters", id: 6, replies: []))
        comments.append(CommentModel(name: "Adele", comment: "New song is comming", id: 7, replies: [CommentModel(name: "SelenaGomez", comment: "You're the best", id: 7, replies: []),
                                                                                                     CommentModel(name: "Rihanna", comment: "I can't wait!", id: 7, replies: [])]))
        return comments
    }
}

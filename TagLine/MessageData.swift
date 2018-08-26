//
//  MessageData.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/26/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import Foundation

class MessageData {
    
    
    
    var messageType : String?  // user id
    var userId : String? // user pass
    var message : String?
   
    init (messageType : String?, userId: String?, message : String?) {
        
        
        self.messageType = messageType
        self.userId = userId
        self.message = message
        
        
    }
    
    
}

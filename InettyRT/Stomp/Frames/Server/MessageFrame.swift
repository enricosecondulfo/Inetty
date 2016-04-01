//
//  MessageFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class MessageFrame: StompServerFrame {
    
    var command:StompFrameServerCommand = StompFrameServerCommand.MESSAGE
    var body: String? = nil
    
    var subscription:String
    var messageId:String
    var destination:String
    var contentType:String?
    
    init(subscription: String, messageId: String, destination: String) {
        self.subscription = subscription
        self.messageId = messageId
        self.destination = destination
    }
}

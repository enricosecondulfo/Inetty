//
//  SendFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class SendFrame: StompClientFrame {

    var command: StompFrameClientCommand = StompFrameClientCommand.SEND
    var destination: String
    var contentType: String = "application/json"
    var body: String? = nil
    
    init(destination: String, body: String) {
        self.destination = destination
        self.body = body
    }
    
    var description: String {
        return "\(self.command.rawValue)\n" +
            "destination:\(self.destination)\n" +
            "content-type:\(self.contentType)\n\n" +
            "\(self.body!)\n\0"
    }
}

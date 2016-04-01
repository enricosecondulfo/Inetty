//
//  SubscribeFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 05/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class SubscribeFrame: StompClientFrame {
    
    var command: StompFrameClientCommand = StompFrameClientCommand.SUBSCRIBE
    var body:String? = nil
    var id:String
    var destination:String
    
    init(id: String, destination: String) {
        self.id = id
        self.destination = destination
    }
    
    var description: String {
        return "\(self.command.rawValue)\n" +
               "id:\(self.id)\n" +
               "destination:\(self.destination)\n\n\0"
    }

}

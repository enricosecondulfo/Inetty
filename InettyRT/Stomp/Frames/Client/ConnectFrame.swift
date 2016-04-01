//
//  ConnectFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 03/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class ConnectFrame: StompClientFrame {
    
    var command: StompFrameClientCommand = StompFrameClientCommand.CONNECT
    var body: String? = nil
    var acceptVersion:String
    var host:String
    
    init(acceptVersion: String, host: String) {
        self.acceptVersion = acceptVersion
        self.host = host
    }
    
    var description: String {
        return "\(self.command.rawValue)\n" +
               "accept-version:\(self.acceptVersion)\n" +
               "host:\(self.host)\n\n\0"
    }

    

    
}

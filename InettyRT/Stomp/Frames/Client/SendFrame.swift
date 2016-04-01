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
    var body: String? = nil
    
    var description: String {
        return ""
    }
}

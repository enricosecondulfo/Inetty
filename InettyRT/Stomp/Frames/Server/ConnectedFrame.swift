//
//  ConnectedFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class ConnectedFrame: StompServerFrame {

    var command: StompFrameServerCommand = StompFrameServerCommand.CONNECTED
    var body: String? = nil
    
    var version: String? = nil
}

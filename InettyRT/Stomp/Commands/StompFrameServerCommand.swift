//
//  StompCommand.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 03/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

enum StompFrameServerCommand: String {
    
    case CONNECTED = "CONNECTED"
    case MESSAGE = "MESSAGE"
    case RECEIPT = "RECEIPT"
    case ERROR = "ERROR"
}

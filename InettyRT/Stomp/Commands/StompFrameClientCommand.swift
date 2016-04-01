//
//  StompFrameClientCommand.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

enum StompFrameClientCommand: String {
    
    case CONNECT = "CONNECT"
    case DISCONNECT = "DISCONNECT"
    case SEND = "SEND"
    case SUBSCRIBE = "SUBSCRIBE"
    case UNSUBSCRIBE = "UNSUBSCRIBE"
    case BEGIN = "BEGIN"
    case COMMIT = "COMMIT"
    case ABORT = "ABORT"
    case ACK = "ACK"
    case NACK = "NACK"
}

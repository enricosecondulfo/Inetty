//
//  ErrorFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class ErrorFrame: StompServerFrame {

    var command:StompFrameServerCommand = StompFrameServerCommand.ERROR
    var body: String? = nil
}

//
//  ReceiptFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

class ReceiptFrame: StompServerFrame {

    var command:StompFrameServerCommand = StompFrameServerCommand.RECEIPT
    var body: String? = nil
}

//
//  StompClientFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

protocol StompClientFrame: StompFrame, CustomStringConvertible {

    var command: StompFrameClientCommand { get }
}

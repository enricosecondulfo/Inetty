//
//  StompServerFrame.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit

protocol StompServerFrame: StompFrame {

    var command: StompFrameServerCommand { get }
    
}

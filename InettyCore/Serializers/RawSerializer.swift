//
//  RawSerializer.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import Gloss

protocol RawSerializer {
    
    func serialize<D where D: Serializable>(entity: D) throws -> NSData?
    
    func serialize<D where D: Serializable>(entity: D) throws -> String?
    
    func deserialize<D where D: Serializable>(data: NSData) throws -> D?
    
    func deserialize<D where D: Serializable>(data: NSData) throws -> [D]?
    
    func deserialize<D where D: Serializable>(text: String) throws -> D?
    
    func deserialize<D where D: Serializable>(text: String) throws -> [D]?

}

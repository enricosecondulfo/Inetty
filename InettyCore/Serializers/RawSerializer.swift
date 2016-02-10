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
    
    func serialize<D where D: RawDomain>(entity: D) throws -> NSData?
    
    func serialize<D where D: RawDomain>(entity: D) throws -> String?
    
    func deserialize<D where D: RawDomain>(data: NSData) throws -> D?
    
    func deserialize<D where D: RawDomain>(data: NSData) throws -> [D]?
    
    func deserialize<D where D: RawDomain>(text: String) throws -> D?
    
    func deserialize<D where D: RawDomain>(text: String) throws -> [D]?

}

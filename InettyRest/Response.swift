//
//  Response.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 14/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import CoreData
import InettyCore

public class Response: BaseCoreDataDomain {
    
    @NSManaged var data: NSData?
    @NSManaged var response: NSData?
    @NSManaged var date: NSDate?
}

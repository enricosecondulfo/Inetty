//
//  ResponseRepository.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 14/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import CoreData
import InettyCore

class ResponseRepository: BaseCoreDataRepository<Response> {

    override init(context: NSManagedObjectContext?) {
        super.init(context: context)
    }
}

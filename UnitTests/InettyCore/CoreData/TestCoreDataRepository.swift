//
//  TestCoreDataRepository.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 12/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore
import CoreData

class TestCoreDataRepository: BaseCoreDataRepository<TestCoreDataDomain> {

    override init(context: NSManagedObjectContext?) {
        super.init(context: context)
    }

}

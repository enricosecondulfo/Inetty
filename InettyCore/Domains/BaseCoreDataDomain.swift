//
//  BaseCoreDataDomain.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 12/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import CoreData

public class BaseCoreDataDomain: NSManagedObject {
    
    @NSManaged public var id: String!
    
    public override required init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}

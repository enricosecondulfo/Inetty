//
//  BaseCoreDataRepository.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 12/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import CoreData

public class BaseCoreDataRepository<D: BaseCoreDataDomain> {
    
    private var context: NSManagedObjectContext?
    
    public init(context: NSManagedObjectContext?) {
        self.context = context
    }
    
    public func create() -> D {
        let entityDescription:NSEntityDescription! = NSEntityDescription.entityForName(String(D.self), inManagedObjectContext: context!)
        
        return D(entity: entityDescription, insertIntoManagedObjectContext: self.context)
    }
    
    public func add(entity: D) {
        try! self.context!.save()
    }
    
    public func findAll(predicate: NSPredicate? = nil) -> [D]? {
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: String(D.self))
        
        if let predicate:NSPredicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        return (try! self.context!.executeFetchRequest(fetchRequest) as? [D])
    }
    
    public func find(id: String) -> D? {
        let predicate:NSPredicate = NSPredicate(format: "%K = %@", "id", id)
        
        guard let entities:[D] = findAll(predicate) where entities.count > 0 else {
            return nil
        }
        
        return entities[0]
    }
    
    public func update(entity:D) {
        if var cachedEntity: D = find(entity.id) {
            cachedEntity = entity
            
            add(cachedEntity)
        }
    }
    
    public func delete(key:String) {
        guard let entity:D = find(key) else {
            return
        }
        
        self.context!.deleteObject(entity)
        try! self.context!.save()
    }

}

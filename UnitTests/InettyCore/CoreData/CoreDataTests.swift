//
//  CoreDataTests.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 12/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import XCTest
import CoreData

class CoreDataTests: XCTestCase {
    
    var context: NSManagedObjectContext?
    var testCoreDataRepository: TestCoreDataRepository?
    
    override func setUp() {
        super.setUp()
        
        self.context = setUpInMemoryManagedObjectContext()
        self.testCoreDataRepository = TestCoreDataRepository(context: self.context!)
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testAddDomain() {
        let testCoreDataDomain: TestCoreDataDomain = testCoreDataRepository!.create()
        testCoreDataDomain.id = "test"
        
        testCoreDataRepository?.add(testCoreDataDomain)
    }
    
    func testFindAllDomains() {
        
        let testCoreDataDomains: [TestCoreDataDomain]? = self.testCoreDataRepository?.findAll()
        print(testCoreDataDomains?[0].id)
    }
    
    private func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext! {
        var managedObjectContext:NSManagedObjectContext!
        
        let bundle:NSBundle = NSBundle(forClass: CoreDataTests.self)
        let modelURL = bundle.URLForResource("BaseCoreDataDomainTests", withExtension: "momd")!
        guard let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL) else {
            
            return nil
        }
        
        do {
            let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            try persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
            
            managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
        } catch {
            
        }
        
        return managedObjectContext
    }

}

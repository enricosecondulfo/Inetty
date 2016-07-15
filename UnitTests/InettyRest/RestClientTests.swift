//
//  RestClientTests.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import XCTest
import CoreData
import InettyRest

class RestClientTests: XCTestCase {
    
    var restClient: RestClient?
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()
    
    override func setUp() {
        super.setUp()
        
        let context: NSManagedObjectContext? = self.setUpInMemoryManagedObjectContext()
        self.restClient = RestClient(context: context, baseUrl: "http://jsonplaceholder.typicode.com")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDoGet() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        restClient?.doGet("/posts", successCallback: { (posts: [Post]?, response: NSHTTPURLResponse?) in
            
            if let posts = posts {
                print(posts.count)
                expectation.fulfill()
            }
            
            }, errorCallback: { (response: NSURLResponse?) in
                expectation.fulfill()
                
        })
        
        //        restClient.doGet("/stores", successCallback: { (stores: [Store]?, response: NSHTTPURLResponse?) -> () in
        //
        //            XCTAssertNotNil(stores)
        //            expectation.fulfill()
        //
        //            }) { (response: NSURLResponse?) -> () in
        //                print("error")
        //                expectation.fulfill()
        //        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testDoPost() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        var tag = Tag()
        tag.name = "test tg"
        
        restClient!.doPost("/tags", entityToAdd: tag, successCallback: { (response: NSHTTPURLResponse?) -> () in
            
            XCTAssertEqual(response?.statusCode, 200)
            expectation.fulfill()
            
        }) { (response: NSURLResponse?) -> () in
            
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testDoUpdate() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        var tag = Tag()
        tag.name = "test tg"
        
        self.restClient!.doUpdate("/tags/56bf552f45ce1b816bbaf090", entityToAdd: tag, successCallback: { (response: NSHTTPURLResponse?) -> () in
            
            XCTAssertEqual(response?.statusCode, 200)
            expectation.fulfill()
            
        }) { (response: NSURLResponse?) -> () in
            
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testDoDelete() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        self.restClient!.doDelete("/tags/56bf552f45ce1b816bbaf090", type: Tag.self, successCallback: { (response: NSHTTPURLResponse?) -> () in
            
            XCTAssertEqual(response?.statusCode, 200)
            expectation.fulfill()
            
        }) { (response: NSURLResponse?) -> () in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    private func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext? {
        var managedObjectContext:NSManagedObjectContext!
        
        let bundle:NSBundle = NSBundle(identifier: "com.mbi.ios.libraries.inetty.InettyRest")!
        let modelURL = bundle.URLForResource("BaseCoreDataDomainTests", withExtension: "momd")!
        guard let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL) else {
            
            return nil
        }
        
        do {
            let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            
            let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("UnitTests")
            
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            
            managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
        } catch {
            
        }
        
        return managedObjectContext
    }
    
}

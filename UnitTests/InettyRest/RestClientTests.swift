//
//  RestClientTests.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import XCTest
import InettyRest

class RestClientTests: XCTestCase {
    
    let restClient: RestClient = RestClient(baseUrl: "http://62.210.129.108:8080/shoopeewebapi")
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDoGet() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        restClient.doGet("/stores", successCallback: { (stores: [Store]?, response: NSHTTPURLResponse?) -> () in
            
            print(stores)
            expectation.fulfill()
            
            }) { (response: NSURLResponse?) -> () in
                print("error")
                expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testDoPost() {
        let expectation:XCTestExpectation! = self.expectationWithDescription("asynchronous request")
        
        var tag = Tag()
        tag.name = "test tg5"
        
        restClient.doPost("/tags", entityToAdd: tag, successCallback: { (response: NSHTTPURLResponse?) -> () in
            
            print("tags added")
            expectation.fulfill()
            
            }) { (response: NSURLResponse?) -> () in
                print("error")
                print(response)
                expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
}

//
//  StompClientTests.swift
//  Inetty
//
//  Created by Paolo Di Capua on 31/03/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import XCTest
import InettyRT

class StompClientTests: XCTestCase {
    
    var stompClient: StompClient?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        self.stompClient = StompClient(url: "ws://server.enjoyit.one:8080/redropwebapi/hello")
        self.stompClient?.delegate = self
        
        self.expectation = self.expectationWithDescription("asynchronous request")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueueSubscription() {
        self.stompClient?.connect();
        
        self.waitForExpectationsWithTimeout(30, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}

extension StompClientTests: StompClientDelegate {
    
    func stompClientDidConnect() {
        self.expectation?.fulfill()
        
        self.stompClient?.subscribe("/app/sensors", callback: { (body: String?) in
            print(body)
        })
        
        self.stompClient?.send("/app/send/notify", body: "{\"blackBoxId\":\"57092ef345cedc1bb5de45b8\",\"operatorId\":\"p.dicapua\",\"state\":\"SEEN\"}")
    }
}
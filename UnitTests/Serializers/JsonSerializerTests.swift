//
//  JsonSerializerTests.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import XCTest
import InettyCore

class JsonSerializerTests: XCTestCase {
    
    let jsonSerializer: JsonSerializer = JsonSerializer()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testSerializer() {
        var subTest: SubTest = SubTest()
        subTest.name = "subTest"
        
        var test: Test = Test()
        test.name = "test"
        test.number =  nil
        test.numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        test.subTest = subTest
        test.subTests = [subTest]
        
        var tests: [Test] = []
        tests.append(test)
        tests.append(test)
        
        do {
            let result: String = try jsonSerializer.serialize(tests)!
            
            print(result)
            
            let test2: Test! = try jsonSerializer.deserialize(result)
            
            print(test2.number)
            
            
        } catch let error as NSError {
            print(error)
        }
    }
    
}

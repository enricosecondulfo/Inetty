//
//  Test.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore
import Gloss

struct Test: RawDomain {

    var name: String?
    var number: Int?
    var numbers: [Int]?
    var subTest: SubTest?
    var subTests: [SubTest]?
    
    init() {
    }
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.number = "number" <~~ json
        self.numbers = "numbers" <~~ json
        self.subTest = "subTest" <~~ json
        self.subTests = "subTests" <~~ json
    }
    
    func toJSON() -> JSON? {
       return jsonify([
           "name" ~~> self.name,
           "number" ~~> self.number,
           "numbers" ~~> self.numbers,
           "subTest" ~~> self.subTest,
           "subTest2" ~~> self.subTests
       ])
    }
}

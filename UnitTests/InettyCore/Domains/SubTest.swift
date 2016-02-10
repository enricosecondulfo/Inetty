//
//  SubTest.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore
import Gloss

struct SubTest: RawDomain {
    
    var name: String?
    
    init() {
    }
    
    init?(json: JSON) {
        self.name = "name" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name
        ])
    }

}

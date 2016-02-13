//
//  Tag.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 12/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyRest
import Gloss

struct Tag: RawDomain {
    
    var id: String?
    var name: String?
    
    init() {
    }
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "name" ~~> self.name
        ])
    }
}

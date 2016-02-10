//
//  Category.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore
import Gloss

struct Category: RawDomain {

    var id: String?
    var name: String?
    
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

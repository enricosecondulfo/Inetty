//
//  Store.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 09/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore
import Gloss

struct Store: RawDomain {

    var id: String?
    var name: String?
    var imageUrl: String?
    var category: Category?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.imageUrl = "imageUrl" <~~ json
        self.category = "category" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "name" ~~> self.name,
            "imageUrl" ~~> self.imageUrl,
            "category" ~~> self.category
        ])
    }
}

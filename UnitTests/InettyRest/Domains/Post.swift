//
//  Post.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 14/07/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import Gloss
import InettyRest

struct Post: RawDomain {
    
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
    
    init() {}
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.userId = "userId" <~~ json
        self.title = "title" <~~ json
        self.body = "body" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "userId" ~~> self.userId,
            "title" ~~> self.title,
            "body" ~~> self.body
            ])
    }
}

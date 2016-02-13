//
//  HttpResponseStatusCode.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit

public enum HttpResponseStatusCode: Int {

    case OK = 200
    case CREATED = 201
    case NOT_MODIFIED = 304
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case NOT_FOUND = 404
    case METHOD_NOT_ALLOWED = 405
    case INTERNAL_SERVER_ERROR = 500
}

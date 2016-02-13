//
//  JsonSerializer.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit

public class JsonSerializer: RawSerializer {
    
    public init() {
    }
    
    public func serialize<D where D: Serializable>(entity: D) throws -> NSData? {
        return try NSJSONSerialization.dataWithJSONObject(entity.toJSON()!, options: [])
    }
    
    public func serialize<D where D: Serializable>(entities: [D]) throws -> NSData? {
        var entitiesDictionary: [[String: AnyObject]] = []
         
        for entity: D in entities {
            entitiesDictionary.append(entity.toJSON()!)
        }
        
        return try NSJSONSerialization.dataWithJSONObject(entitiesDictionary, options: [])
    }
    
    public func serialize<D where D: Serializable>(entity: D) throws -> String? {
        return try String(data: serialize(entity)!, encoding: NSUTF8StringEncoding)
    }
    
    public func serialize<D where D: Serializable>(entities: [D]) throws -> String? {
        return try String(data: serialize(entities)!, encoding:  NSUTF8StringEncoding)
    }
    
    public func deserialize<D where D: Serializable>(data: NSData) throws -> D? {
        var entities: [D]? = try deserialize(data)
        
        return entities != nil && entities!.count > 0 ? entities![0] : nil
    }
    
    public func deserialize<D where D: Serializable>(data: NSData) throws -> [D]? {
        var entities: [D] = []
        
        let result: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        
        if let result = result as? Dictionary<String, AnyObject> {
            entities = [D(json: result)!]
            
        } else if let result = result as? [[String: AnyObject]] {
            for element: [String: AnyObject] in result {
                entities.append(D(json: element)!)
            }
        }
        
        return entities
    }
    
    public func deserialize<D where D : Serializable>(text: String) throws -> D? {
        var entities: [D]! = try deserialize(text)
        
        return entities != nil && entities.count > 0 ? entities[0] : nil
    }

    public func deserialize<D where D : Serializable>(text: String) throws -> [D]? {
        return try deserialize(text.dataUsingEncoding(NSUTF8StringEncoding)!)
    }

}

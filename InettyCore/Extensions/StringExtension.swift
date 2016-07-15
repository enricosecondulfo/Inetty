//
//  StringExtension.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 27/12/15.
//  Copyright © 2015 mbinnovation. All rights reserved.
//

import UIKit

public extension String {
    
    subscript(aRange: NSRange) -> String? {
        get {
            return self.substringWithRange(self.rangeFromNSRage(aRange))
        }
    }
    
    func substringWithRange(aRange:NSRange) -> String? {
        return self.substringWithRange(self.rangeFromNSRage(aRange))
    }
    
    func dropFirstCharacter() -> String {
        return isEmpty ? "" : String(characters.dropFirst())
    }
    
    func toBase64() -> NSData? {
        let stringData:NSData! = self.dataUsingEncoding(NSUTF8StringEncoding)
        return stringData.base64EncodedDataWithOptions([])
    }
    
    func toBase64String() -> String {
        let base64StringData:NSData! = toBase64()
        return NSString(data: base64StringData, encoding: NSUTF8StringEncoding) as! String
    }
    
    func snakeToCamelCase() -> String? {
        var camelCaseString:String = self
        
        let regex:NSRegularExpression = try! NSRegularExpression(pattern: "_+(.)", options: [])
        let matches:[NSTextCheckingResult] = regex.matchesInString(camelCaseString, options: [], range: NSMakeRange(0, camelCaseString.characters.count)).reverse()
        
        for match:NSTextCheckingResult in matches {
            let matchRange:Range<String.Index> = camelCaseString.rangeFromNSRage(match.range)
            let upperCaseReplacedString:String = camelCaseString[match.range]!.uppercaseString
            
            camelCaseString.replaceRange(matchRange, with: upperCaseReplacedString.dropFirstCharacter())
        }
        
        if (camelCaseString.hasPrefix("_")) {
            camelCaseString = camelCaseString.dropFirstCharacter()
        }
        
        return camelCaseString
    }
    
    func rangeFromNSRage(aRange: NSRange) -> Range<String.Index> {
        let start = self.startIndex.advancedBy(aRange.location)
        let end = self.startIndex.advancedBy(aRange.location + aRange.length)
        
        return start..<end
    }
    
    public func onlyCharacters() -> String {
        var output:String = ""
        
        for character in self.characters {
            if (character != "\0") {
                output.append(character)
            }
        }
        
        return output;
    }
}


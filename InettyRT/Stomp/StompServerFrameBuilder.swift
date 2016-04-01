//
//  StompServerFrameBuilder.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 04/01/16.
//  Copyright © 2016 mbinnovation. All rights reserved.
//

import UIKit
import InettyCore

class StompServerFrameBuilder {

    class func build(data: String) throws -> StompServerFrame! {
        var frameComponents:[String] = data.componentsSeparatedByString("\n")
        
        guard frameComponents.count > 1 else {
            throw StompServerFrameBuilderError.FewComponents
        }
        
        let command:String = frameComponents.removeAtIndex(0)
        let body:String = frameComponents.removeLast().onlyCharacters()
        var headers:[String: String] = [:]
        
        frameComponents.removeLast()
        
        for header in frameComponents {
            let keyValueHeader:[String] = header.componentsSeparatedByString(":")
            
            guard keyValueHeader.count > 1 else {
                throw StompServerFrameBuilderError.ErrorHeader
            }
            
            let keyHeader:String = keyValueHeader[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let valueHeader:String = keyValueHeader[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            headers[keyHeader] = valueHeader
        }
        
        switch command {
            
        case "CONNECTED":
            let connectedFrame:ConnectedFrame = ConnectedFrame()
            connectedFrame.version = headers["version"]
            
            return connectedFrame
            
        case "MESSAGE":
            let messageFrame:MessageFrame = MessageFrame(subscription: headers["subscription"]!, messageId: headers["message-id"]!, destination: headers["destination"]!)
            messageFrame.contentType = headers["content-type"]
            messageFrame.body = body
            
            return messageFrame
            
        default:
            break
            
        }
        
        return nil
    }
}

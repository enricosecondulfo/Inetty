//
//  StompClient.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 27/12/15.
//  Copyright © 2015 mbinnovation. All rights reserved.
//

import UIKit
import InettyCore

public class StompClient {
    
    private var webSocket:WebSocket?
    public var delegate:StompClientDelegate?
    
    private var jsonSerializer:JsonSerializer = JsonSerializer()
    
    private var subscriptions:[String: ((String?) -> ())!] = [:]
    
    public init(url:String) {
        self.webSocket = WebSocket(url: NSURL(string: url)!, protocols: ["chat", "superchat"])
        self.webSocket?.delegate = self
        
        self.jsonSerializer = JsonSerializer()
    }
    
    public func connect() {
        self.webSocket?.connect()
    }
    
    public func send(destination: String, body: String) {
        let sendFrame: SendFrame = SendFrame(destination: destination, body: body)
        
        transmit(sendFrame)
    }
    
    public func subscribe(destination: String, callback: ((String?) -> ())!) {
        let subscriptionId:String = generateSubscriptionId()
        
        let subscribeFrame: SubscribeFrame = SubscribeFrame(id: subscriptionId, destination: destination)
        self.subscriptions[subscriptionId] = callback
        
        transmit(subscribeFrame)
    }
    
    private func transmit(frame: StompClientFrame) {
        print(frame.description)
        self.webSocket?.writeString(frame.description)
    }
    
    private func generateSubscriptionId() -> String {
        return "sub-\(NSDate().timeIntervalSince1970 * 1000)"
    }
}

extension StompClient: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        
        
        let connectFrame:ConnectFrame = ConnectFrame(acceptVersion: "1.2", host: "www.test.com")
        transmit(connectFrame)
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print(text)
        
        do {
            let serverFrame:StompServerFrame = try StompServerFrameBuilder.build(text)
            
            switch serverFrame.command {
                
            case .CONNECTED:
                self.delegate?.stompClientDidConnect()
                break
                
            case .MESSAGE:
                let messageFrame: MessageFrame = serverFrame as! MessageFrame
                let subscription: ((String?) -> ())! = self.subscriptions[messageFrame.subscription]!
                
                subscription(messageFrame.body)
                break
                
            default:
                break
            }
            
        } catch {
            print("error")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        
    }
}

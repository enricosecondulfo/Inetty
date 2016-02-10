//
//  RestClient.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import InettyCore

public class RestClient {
    
    let DEFAULT_CONTENT_TYPE = "application/json;charset=UTF-8"
    let DEFAULT_ACCEPT = "application/json"
    
    var baseUrl:String
    let jsonSerializer: JsonSerializer = JsonSerializer()

    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    /**
     Execute get request
     
     - Parameters:
     - url: The endpoint url
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doGet<D where D: RawDomain>(url:String, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())!, errorCallback: ((response:NSURLResponse?) -> ())!) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.NOT_MODIFIED]
        
        doGet(url, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    
    /**
     Execute get request
     
     - Parameters:
     - url: The endpoint url
     - successStatusCodes: The codes wich determine that the call was successful
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doGet<D where D: RawDomain>(url: String, successStatusCodes:[HttpResponseStatusCode], successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())!, errorCallback: ((response:NSURLResponse?) -> ())!) {
        
        let request: NSMutableURLRequest = createRequest(HttpMethod.GET, url: url, httpContentType: HttpContentType.json, httpAccept: HttpAccept.json, additionalValuesHeader: nil)
        
        execute(request, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallaback: errorCallback)
    }
    
    private func execute<D where D: RawDomain>(request: NSMutableURLRequest, successStatusCodes:[HttpResponseStatusCode], successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())!, errorCallaback: ((response:NSURLResponse?) -> ())!) {
                
        let urlSession:NSURLSession = NSURLSession.sharedSession()

        let task:NSURLSessionTask = urlSession.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let httpResponse:NSHTTPURLResponse = response as? NSHTTPURLResponse {
                
                print(httpResponse.statusCode)
                
                if successStatusCodes.contains(HttpResponseStatusCode(rawValue: httpResponse.statusCode)!) {
                    
                    if  let data: NSData = data {
                        
                        do {
                    
                            let entities: [D]! = try self.jsonSerializer.deserialize(data)!
                            
                            successCallback(entities: entities, response: httpResponse)
                            
                        } catch {
                            errorCallaback(response: response)
                            return
                        }
                    }
                    
                } else {
                    errorCallaback(response: response)
                }
            }
        }
        
        task.resume()
    }
    
    private func createRequest(httpMethod: HttpMethod, url: String, httpContentType: HttpContentType, httpAccept: HttpAccept, additionalValuesHeader:[String: String]?) -> NSMutableURLRequest {
        
        let request:NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: "\(self.baseUrl)\(url)")
        request.HTTPMethod = httpMethod.rawValue
        
        if (httpContentType != HttpContentType.none) {
            request.addValue(httpContentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        
        if (httpAccept != HttpAccept.none) {
            request.addValue(httpAccept.rawValue, forHTTPHeaderField: "Accept")
        }
        
        if let additionalValuesHeader:[String: String] = additionalValuesHeader {
            for (key, value) in additionalValuesHeader {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    private func createRequest<D where D: RawDomain>(httpMethod:HttpMethod, url: String, httpContentType: HttpContentType, httpAccept: HttpAccept, additionalValuesHeader:[String: String]?, entityToAdd:D?) -> NSMutableURLRequest {
        
        let request:NSMutableURLRequest = createRequest(httpMethod, url: url, httpContentType: httpContentType, httpAccept: httpAccept, additionalValuesHeader: nil)
        
        if let entityToAdd:D = entityToAdd {
            request.HTTPBody = try! self.jsonSerializer.serialize(entityToAdd)
        }
        
        return request
    }




    
    

}

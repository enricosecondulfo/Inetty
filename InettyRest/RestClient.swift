//
//  RestClient.swift
//  Inetty
//
//  Created by Enrico Secondulfo on 08/02/16.
//  Copyright © 2016 major bit innovation. All rights reserved.
//

import UIKit
import CoreData
import InettyCore
import Reachability

public class RestClient {
    
    let DEFAULT_CONTENT_TYPE = "application/json;charset=UTF-8"
    let DEFAULT_ACCEPT = "application/json"
    
    let jsonSerializer: JsonSerializer = JsonSerializer()
    let responseRepository: ResponseRepository?
    let reachability: Reachability?
    
    var context: NSManagedObjectContext?
    var baseUrl:String
    
//    public init(baseUrl: String) {
//        self.baseUrl = baseUrl
//        self.context = nil
//        self.responseRepository = ResponseRepository(context: nil)
//        
//        do {
//            self.reachability = try Reachability.reachabilityForInternetConnection()
//        } catch {
//            self.reachability = nil
//        }
//    }
    
    public init(context:NSManagedObjectContext?, baseUrl: String) {
        self.context = context
        self.baseUrl = baseUrl
        
        self.responseRepository = ResponseRepository(context: self.context!)
        
        do {
            self.reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            self.reachability = nil
        }
    }
    
    /**
     Execute get request
     
     - Parameters:
     - url: The endpoint url
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doGet<D where D: RawDomain>(url:String, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
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
        
        execute(request, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    /**
     Execute post request
     
     - Parameters:
     - url: The endpoint url
     - entityToAdd: The entity that you want to add
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doPost<D where D: RawDomain>(url:String, entityToAdd:D?, successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.CREATED]
        
        doPost(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    /**
     Execute post request
     
     - Parameters:
     - url: The endpoint url
     - successStatusCodes: The codes wich determine that the call was successful
     - entityToAdd: The entity that you want to add
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doPost<D where D: RawDomain>(url:String, successStatusCodes:[HttpResponseStatusCode], entityToAdd:D?, successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        doPost(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: { (entities: [D]?, response:NSHTTPURLResponse?) -> () in
            successCallback!(response: response)
            
        }) { (response:NSURLResponse?) -> () in
            errorCallback!(response: response)
        }
    }
    
    public func doPost<D where D: RawDomain>(url:String, entityToAdd:D?, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.CREATED]
        
        doPost(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    public func doPost<D where D: RawDomain>(url:String, successStatusCodes:[HttpResponseStatusCode], entityToAdd: D?, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let request:NSMutableURLRequest = createRequest(HttpMethod.POST, url: url, httpContentType: HttpContentType.json, httpAccept: HttpAccept.json, additionalValuesHeader: nil, entityToAdd: entityToAdd)
        
        execute(request, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    /**
     Execute update request
     
     - Parameters:
     - url: The endpoint url
     - entityToAdd: The entity that you want to update
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doUpdate<D where D: RawDomain>(url:String, entityToAdd: D?, successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.CREATED]
        
        doUpdate(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    
    /**
     Execute post request
     
     - Parameters:
     - url: The endpoint url
     - successStatusCodes: The codes wich determine that the call was successful
     - entityToAdd: The entity that you want to update
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doUpdate<D where D: RawDomain>(url:String, successStatusCodes:[HttpResponseStatusCode], entityToAdd:D?, successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        doUpdate(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: { (entities: [D]?, response:NSHTTPURLResponse?) -> () in
            successCallback?(response: response)
            
        }) { (response:NSURLResponse?) -> () in
            errorCallback?(response: response)
        }
    }
    
    public func doUpdate<D where D: RawDomain>(url:String, entityToAdd:D?, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())!, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.CREATED]
        
        doUpdate(url, successStatusCodes: successStatusCodes, entityToAdd: entityToAdd, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    public func doUpdate<D where D: RawDomain>(url:String, successStatusCodes:[HttpResponseStatusCode], entityToAdd: D?, successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let request:NSMutableURLRequest = createRequest(HttpMethod.PUT, url: url, httpContentType: HttpContentType.json, httpAccept: HttpAccept.json, additionalValuesHeader: nil, entityToAdd: entityToAdd)
        
        execute(request, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    /**
     Execute delete request
     
     - Parameters:
     - url: The endpoint url
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doDelete<D where D: RawDomain>(url:String, type: D.Type, successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let successStatusCodes:[HttpResponseStatusCode] = [HttpResponseStatusCode.OK, HttpResponseStatusCode.CREATED]
        
        doDelete(url, type: type, successStatusCodes: successStatusCodes, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    /**
     Execute delete request
     
     - Parameters:
     - url: The endpoint url
     - successStatusCodes: The codes wich determine that the call was successful
     - successCallback: The callback called when the status code of the response i
     - errorCallback: The callback called when the status code is different from the codes of success
     */
    public func doDelete<D where D: RawDomain>(url:String, type: D.Type, successStatusCodes:[HttpResponseStatusCode], successCallback: ((response:NSHTTPURLResponse?) -> ())?, errorCallback: ((response:NSURLResponse?) -> ())?) {
        
        let request:NSMutableURLRequest = createRequest(HttpMethod.DELETE, url: url, httpContentType: HttpContentType.json, httpAccept: HttpAccept.json, additionalValuesHeader: nil)
        
        execute(request, successStatusCodes: successStatusCodes, successCallback: { (entities: [D]?, response:NSHTTPURLResponse?) -> () in
            
            successCallback?(response: response)
            
        }) { (response:NSURLResponse?) -> () in
            errorCallback?(response: response)
        }
    }
    
    private func execute<D where D: RawDomain>(request: NSMutableURLRequest, successStatusCodes:[HttpResponseStatusCode], successCallback: ((entities: [D]?, response:NSHTTPURLResponse?) -> ())? = nil, errorCallback: ((response:NSURLResponse?) -> ())? = nil) {
        
        let urlSession:NSURLSession = NSURLSession.sharedSession()
        
        if let reachability = self.reachability where reachability.currentReachabilityStatus == Reachability.NetworkStatus.NotReachable {
            print("reachable")
            
            if let r = self.responseRepository?.find((request.URL?.absoluteString)!) {
                
                do {
                    let resp: NSHTTPURLResponse? = NSKeyedUnarchiver.unarchiveObjectWithData(r.response!) as? NSHTTPURLResponse
                    
                    let entities: [D]? = try self.jsonSerializer.deserialize((r.data)!)
                    
                    successCallback?(entities: entities, response: resp)
                    
                } catch {
                    errorCallback?(response: nil)
                    return
            }
            } else {
             errorCallback?(response: nil)   
            }
            
        } else {
            
            let task:NSURLSessionTask = urlSession.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                
                guard let httpResponse: NSHTTPURLResponse = response as? NSHTTPURLResponse where successStatusCodes.contains(HttpResponseStatusCode(rawValue: httpResponse.statusCode)!) else {
                    
                    errorCallback?(response: response)
                    return
                }
                
                let callResponse: Response? = self.responseRepository?.create()
                callResponse?.id = request.URL?.absoluteString
                callResponse?.response =  NSKeyedArchiver.archivedDataWithRootObject(response!)

                callResponse?.data = data
                callResponse?.date = NSDate()
                
                self.responseRepository?.add(callResponse!)
                
                
                guard let data: NSData = data where data.length > 0 else {
                    successCallback?(entities: nil, response: httpResponse)
                    return
                }
                
                do {
                    let entities: [D]? = try self.jsonSerializer.deserialize(data)
                    
                    successCallback?(entities: entities, response: httpResponse)
                    
                } catch {
                    errorCallback?(response: response)
                    return
                }
            }
            
            task.resume()
        }
        
        
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

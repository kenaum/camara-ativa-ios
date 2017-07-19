//
//  HTTPRequest.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import Alamofire

protocol OnResultCallback {
    func onInit()
    func resultCallback(nsData: NSDictionary)
    func resultCallbackWithError(error: ErrorType)
}

class OnResultCallbackClass {
    var delegate:OnResultCallback?
    
    func onInit() {
        delegate?.onInit()
    }
    
    func resultCallback(nsData: NSDictionary) {
        delegate?.resultCallback(nsData)
    }
    
    func resultCallbackWithError(error: ErrorType) {
        delegate?.resultCallbackWithError(error)
    }
}

class HTTPRequest: NSObject, OnResultCallback {
    var url = NSURL()
    let onResultCallbackClass = OnResultCallbackClass()
    var alamofireManager : Alamofire.Manager?
    
    required override init() {
        
    }
    
    required init(url: NSString) {
        super.init()
        self.url = NSURL(string: url as String)!
        onResultCallbackClass.delegate = self
    }
    
    func onInit() {
        
    }
    
    func connect(params: [String: AnyObject]) {
        self.onResultCallbackClass.onInit()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForResource = 10
        
        print(url.absoluteString)
        //print(params)
        
        self.alamofireManager = Alamofire.Manager(configuration: configuration)
        alamofireManager!.request(.POST, url, parameters: params)
            .response { request, response, data, error in
                //print(request)
                //print(response)
                //print(error)
                
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        //print(jsonResult)
                        
                        self.onResultCallbackClass.resultCallback(jsonResult)
                    }
                } catch {
                    print(error)
                    self.onResultCallbackClass.resultCallbackWithError(error)
                }
        }
    }
    
    func connectWithGet(params: [String: AnyObject]) {
        self.onResultCallbackClass.onInit()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForResource = 10
        
        print(url.absoluteString)
        //print(params)
        
        self.alamofireManager = Alamofire.Manager(configuration: configuration)
        alamofireManager!.request(.GET, url, parameters: params)
            .response { request, response, data, error in
                print(request)
                print(response)
                print(error)
                
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        print(jsonResult)
                        
                        self.onResultCallbackClass.resultCallback(jsonResult)
                    }
                } catch {
                    print(error)
                    self.onResultCallbackClass.resultCallbackWithError(error)
                }
        }
    }
    
    func resultCallback(nsData: NSDictionary) {
        print(nsData)
    }
    
    func resultCallbackWithError(error: ErrorType) {
        print(error)
    }
}
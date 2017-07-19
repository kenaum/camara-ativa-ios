//
//  VereadoresController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import CoreData

protocol OnResultVereadorCallback {
    func onInitVereador()
    
    func resultVereadorCallback(nsData: NSDictionary)
    
    func resultVereadorCallbackWithError(error: ErrorType)
}

class OnResultVereadorCallbackClass {
    var delegate:OnResultVereadorCallback?
    
    func onInitVereador() {
        delegate?.onInitVereador()
    }
    
    func resultVereadorCallback(nsData: NSDictionary) {
        delegate?.resultVereadorCallback(nsData)
    }
    
    func resultVereadorCallbackWithError(error: ErrorType) {
        delegate?.resultVereadorCallbackWithError(error)
    }
}

class VereadoresController: NSObject, OnResultCallback, OnResultVereadorCallback {
    private var url = String()
    let onResultVereadorCallbackClass = OnResultVereadorCallbackClass()
    
    private var user: User!
    
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    
    required init(url: String) {
        super.init()
        self.url = url
        onResultVereadorCallbackClass.delegate = self
    }
    
    required override init() {
        
    }
    
    func getVereadores() {
        let params = [
            HTTPCons.keyTag: "findAldermen"
        ]
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    func resultCallback(nsData: NSDictionary) {
        //print(nsData)
        onResultVereadorCallbackClass.resultVereadorCallback(nsData)
    }
    
    func resultCallbackWithError(error: ErrorType) {
        //print(error)
        onResultVereadorCallbackClass.resultVereadorCallbackWithError(error)
    }
    
    func onInit() {
        self.onInitVereador()
    }
    
    func onInitVereador() {
        onResultVereadorCallbackClass.onInitVereador()
    }
    
    func resultVereadorCallback(nsData: NSDictionary) {
        print(nsData)
    }
    
    func resultVereadorCallbackWithError(error: ErrorType) {
        print(error)
    }
}
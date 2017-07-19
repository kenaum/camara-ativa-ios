//
//  NoticiasController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import CoreData

protocol OnResultNoticiaCallback {
    func onInitNoticia()
    
    func resultNoticiaCallback(nsData: NSDictionary)
    
    func resultNoticiaCallbackWithError(error: ErrorType)
}

class OnResultNoticiaCallbackClass {
    var delegate:OnResultNoticiaCallback?
    
    func onInitNoticia() {
        delegate?.onInitNoticia()
    }
    
    func resultNoticiaCallback(nsData: NSDictionary) {
        delegate?.resultNoticiaCallback(nsData)
    }
    
    func resultNoticiaCallbackWithError(error: ErrorType) {
        delegate?.resultNoticiaCallbackWithError(error)
    }
}

class NoticiasController: NSObject, OnResultCallback, OnResultNoticiaCallback {
    private var url = String()
    let onResultNoticiaCallbackClass = OnResultNoticiaCallbackClass()
    
    private var user: User!
    
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    
    required init(url: String) {
        super.init()
        self.url = url
        onResultNoticiaCallbackClass.delegate = self
    }
    
    required override init() {
        
    }
    
    func getNoticias() {
        let params = [String: String]()
        
        let httpRequest = HTTPRequest(url: HTTPCons.getURLFindNoticia)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    func resultCallback(nsData: NSDictionary) {
        //print(nsData)
        onResultNoticiaCallbackClass.resultNoticiaCallback(nsData)
    }
    
    func resultCallbackWithError(error: ErrorType) {
        //print(error)
        onResultNoticiaCallbackClass.resultNoticiaCallbackWithError(error)
    }
    
    func onInit() {
        self.onInitNoticia()
    }
    
    func onInitNoticia() {
        onResultNoticiaCallbackClass.onInitNoticia()
    }
    
    func resultNoticiaCallback(nsData: NSDictionary) {
        //print(nsData)
    }
    
    func resultNoticiaCallbackWithError(error: ErrorType) {
        //print(error)
    }
}

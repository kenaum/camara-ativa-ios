//
//  Solicitacao.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class Solicitacao: NSObject {
    private var _id: Int? = nil
    private var _latitude: String? = nil
    private var _longitude: String? = nil
    private var _endereco: String? = nil
    private var _requestType: RequestType? = nil
    private var _status: RequestStatus? = nil
    private var _user: User? = nil
    
    var id: Int {
        set {
            self._id = newValue
        }
        
        get {
            return self._id!
        }
    }
    
    var latitude: String {
        set {
            self._latitude = newValue
        }
        
        get {
            return self._latitude!
        }
    }
    
    var longitude: String {
        set {
            self._longitude = newValue
        }
        
        get {
            return self._longitude!
        }
    }
    
    var endereco: String {
        set {
            self._endereco = newValue
        }
        
        get {
            return self._endereco!
        }
    }
    
    var requestType: RequestType {
        set {
            self._requestType = newValue
        }
        
        get {
            return self._requestType!
        }
    }
    
    var status: RequestStatus {
        set {
            self._status = newValue
        }
        
        get {
            return self._status!
        }
    }
    
    var user: User {
        set {
            self._user = newValue
        }
        
        get {
            return self._user!
        }
    }
}
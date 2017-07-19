//
//  User.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class User: NSObject {
    private var _id: String? = nil
    private var _username: String? = nil
    private var _password: String? = nil
    private var _name: String? = nil
    private var _telefone: String? = nil
    private var _isLogged: Bool? = nil
    private var _isBlocked: Bool? = nil
    
    var id: String {
        set {
            self._id = newValue
        }
        
        get {
            return self._id!
        }
    }
    
    var username: String {
        set {
            self._username = newValue
        }
        
        get {
            return self._username!
        }
    }
    
    var password: String {
        set {
            self._password = newValue
        }
        
        get {
            return self._password!
        }
    }
    
    var name: String {
        set {
            self._name = newValue
        }
        
        get {
            return self._name!
        }
    }
    
    var telefone: String {
        set {
            self._telefone = newValue
        }
        
        get {
            return self._telefone!
        }
    }
    
    var isLogged: Bool? {
        set {
            self._isLogged = newValue
        }
        
        get {
            return self._isLogged!
        }
    }
    
    var isBlocked: Bool {
        set {
            self._isBlocked = newValue
        }
        
        get {
            return self._isBlocked!
        }
    }
}

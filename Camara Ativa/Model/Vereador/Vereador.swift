//
//  Vereador.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class Vereador: NSObject {
    private var _id: Int? = nil
    private var _vereadorNome: String? = nil
    private var _vereadorBiografia: String? = nil
    private var _vereadorFoto: String? = nil
    private var _vereadorPartido: String? = nil
    private var _vereadorTwitter: String? = nil
    private var _vereadorEmail: String? = nil
    private var _vereadorFacebook: String? = nil
    private var _vereadorSite: String? = nil
    private var _vereadorTelefone: [VereadorTelefone]? = nil
    
    var id: Int {
        set {
            self._id = newValue
        }
        
        get {
            return self._id!
        }
    }
    
    var vereadorNome: String {
        set {
            self._vereadorNome = newValue
        }
        
        get {
            return self._vereadorNome!
        }
    }
    
    var vereadorBiografia: String {
        set {
            self._vereadorBiografia = newValue
        }
        
        get {
            return self._vereadorBiografia!
        }
    }
    
    var vereadorFoto: String {
        set {
            self._vereadorFoto = newValue
        }
        
        get {
            return self._vereadorFoto!
        }
    }
    
    var vereadorPartido: String {
        set {
            self._vereadorPartido = newValue
        }
        
        get {
            return self._vereadorPartido!
        }
    }
    
    var vereadorTwitter: String {
        set {
            self._vereadorTwitter = newValue
        }
        
        get {
            return self._vereadorTwitter!
        }
    }
    
    var vereadorEmail: String {
        set {
            self._vereadorEmail = newValue
        }
        
        get {
            return self._vereadorEmail!
        }
    }
    
    var vereadorFacebook: String {
        set {
            self._vereadorFacebook = newValue
        }
        
        get {
            return self._vereadorFacebook!
        }
    }
    
    var vereadorSite: String {
        set {
            self._vereadorSite = newValue
        }
        
        get {
            return self._vereadorSite!
        }
    }
    
    var vereadorTelefone: [VereadorTelefone] {
        set {
            self._vereadorTelefone = newValue
        }
        
        get {
            return self._vereadorTelefone!
        }
    }
}
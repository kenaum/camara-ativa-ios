//
//  Noticia.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class Noticia: NSObject {
    private var _pg: Int? = nil
    private var _pgs: Int? = nil
    private var _noticia_id: Int? = nil
    private var _data: String? = nil
    private var _titulo: String? = nil
    private var _resumo: String? = nil
    private var _link: String? = nil
    
    var pg: Int {
        set {
            self._pg = newValue
        }
        
        get {
            return self._pg!
        }
    }
    
    var pgs: Int {
        set {
            self._pgs = newValue
        }
        
        get {
            return self._pgs!
        }
    }
    
    var noticia_id: Int {
        set {
            self._noticia_id = newValue
        }
        
        get {
            return self._noticia_id!
        }
    }
    
    var data: String {
        set {
            self._data = newValue
        }
        
        get {
            return self._data!
        }
    }
    
    var titulo: String {
        set {
            self._titulo = newValue
        }
        
        get {
            return self._titulo!
        }
    }
    
    var resumo: String {
        set {
            self._resumo = newValue
        }
        
        get {
            return self._resumo!
        }
    }
    
    var link: String {
        set {
            self._link = newValue
        }
        
        get {
            return self._link!
        }
    }
}
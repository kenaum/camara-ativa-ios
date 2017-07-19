//
//  VereadorTelefone.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class VereadorTelefone: NSObject {
    private var _id: Int? = nil
    private var _telefone: String? = nil
    
    var id: Int {
        set {
            self._id = newValue
        }
        
        get {
            return self._id!
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
}
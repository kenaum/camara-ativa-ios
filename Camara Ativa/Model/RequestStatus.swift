//
//  RequestStatus.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class RequestStatus: NSObject {
    private var _id: Int? = nil
    private var _nome: String? = nil
    
    var id: Int {
        set {
            self._id = newValue
        }
        
        get {
            return self._id!
        }
    }
    
    var nome: String {
        set {
            self._nome = newValue
        }
        
        get {
            return self._nome!
        }
    }
}
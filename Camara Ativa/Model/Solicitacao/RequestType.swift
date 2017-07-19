//
//  RequestType.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class RequestType: NSObject {
    private var _solicitacao_id: Int? = nil
    private var _nomeSolicitacao: String? = nil
    private var _descSolicitacao: String? = nil
    private var _imgSolicitacao: String? = nil
    
    var solicitacao_id: Int {
        set {
            self._solicitacao_id = newValue
        }
        
        get {
            return self._solicitacao_id!
        }
    }
    
    var nomeSolicitacao: String {
        set {
            self._nomeSolicitacao = newValue
        }
        
        get {
            return self._nomeSolicitacao!
        }
    }
    
    var descSolicitacao: String {
        set {
            self._descSolicitacao = newValue
        }
        
        get {
            return self._descSolicitacao!
        }
    }
    
    var imgSolicitacao: String {
        set {
            self._imgSolicitacao = newValue
        }
        
        get {
            return self._imgSolicitacao!
        }
    }
}
//
//  SolicitacoesController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import CoreData

protocol OnResultSolicitacaoCallback {
    func onInitSolicitacao()
    
    func resultSolicitacaoCallback(nsData: NSDictionary)
    
    func resultSolicitacaoCallbackWithError(error: ErrorType)
    
    func resultSaveSolicitacaoCallback(nsData: NSDictionary)
    
    func resultSaveSolicitacaoCallbackWithError(error: ErrorType)
}

class OnResultSolicitacaoCallbackClass {
    var delegate:OnResultSolicitacaoCallback?
    
    func onInitSolicitacao() {
        delegate?.onInitSolicitacao()
    }
    
    func resultSolicitacaoCallback(nsData: NSDictionary) {
        delegate?.resultSolicitacaoCallback(nsData)
    }
    
    func resultSolicitacaoCallbackWithError(error: ErrorType) {
        delegate?.resultSolicitacaoCallbackWithError(error)
    }
    
    func resultSaveSolicitacaoCallback(nsData: NSDictionary) {
        delegate?.resultSaveSolicitacaoCallback(nsData)
    }
    
    func resultSaveSolicitacaoCallbackWithError(error: ErrorType) {
        delegate?.resultSaveSolicitacaoCallbackWithError(error)
    }
}

class SolicitacoesController: NSObject, OnResultCallback, OnResultSolicitacaoCallback {
    internal enum EnumAction : String {
        case Get          = "Get"
        case Save         = "Save"
    }
    
    internal var enumAction: EnumAction!
    
    private var url = String()
    let onResultSolicitacaoCallbackClass = OnResultSolicitacaoCallbackClass()
    
    private var user: User!
    
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    
    required init(url: String) {
        super.init()
        self.url = url
        onResultSolicitacaoCallbackClass.delegate = self
    }
    
    required override init() {
        
    }
    
    func getSolicitacoes() {
        enumAction = EnumAction.Get
        
        let params = [
            HTTPCons.keyTag : HTTPCons.keyFindRequestTypes
        ]
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    func saveRequest(solicitacao: Solicitacao, imgBase64: String?) {
        enumAction = EnumAction.Save
        
        var params: [String: AnyObject]!
        
        params = [
            HTTPCons.keyTag : HTTPCons.keySaveRequest,
            HTTPCons.keyLatitude : solicitacao.latitude,
            HTTPCons.keyLongitude : solicitacao.longitude,
            HTTPCons.keyEndereco : solicitacao.endereco,
            HTTPCons.keyRequestType : solicitacao.requestType.solicitacao_id,
            HTTPCons.keyStatus : solicitacao.status.id,
            HTTPCons.keyUser : solicitacao.user.id
        ]
        
        if imgBase64 != nil {
            params.updateValue(imgBase64!, forKey: HTTPCons.keyRequestImage)
        }
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    func resultCallback(nsData: NSDictionary) {
        //print(nsData)
        switch enumAction! {
        case EnumAction.Get:
            onResultSolicitacaoCallbackClass.resultSolicitacaoCallback(nsData)
            break;
            
        case EnumAction.Save:
            onResultSolicitacaoCallbackClass.resultSaveSolicitacaoCallback(nsData)
            break;
        }
    }
    
    func resultCallbackWithError(error: ErrorType) {
        //print(error)
        switch enumAction! {
        case EnumAction.Get:
            onResultSolicitacaoCallbackClass.resultSolicitacaoCallbackWithError(error)
            break;
            
        case EnumAction.Save:
            onResultSolicitacaoCallbackClass.resultSaveSolicitacaoCallbackWithError(error)
            break;
        }
    }
    
    func onInit() {
        self.onInitSolicitacao()
    }
    
    func onInitSolicitacao() {
        onResultSolicitacaoCallbackClass.onInitSolicitacao()
    }
    
    func resultSolicitacaoCallback(nsData: NSDictionary) {
        //print(nsData)
    }
    
    func resultSolicitacaoCallbackWithError(error: ErrorType) {
        //print(error)
    }
    
    func resultSaveSolicitacaoCallback(nsData: NSDictionary) {
        //print(nsData)
    }
    
    func resultSaveSolicitacaoCallbackWithError(error: ErrorType) {
        //print(error)
    }
}

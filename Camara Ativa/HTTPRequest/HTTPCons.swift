//
//  HTTPCons.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class HTTPCons: NSObject {
    // URL
    private static let URLCAMARA  = "http://www.camara.ms.gov.br/"
    
    // Main URLRODOLFOORTALE
    private static let URLRODOLFOORTALE  = "http://rodolfoortale.com.br/camaraativa/camara_ativa_ws_old/camara-ativa/"
    
    /*
     * Default fields
     */
    static let keyId = "id"
    static let keyIdUser = "id_user"
    static let keyUser = "user"
    static let keyPassword = "password"
    static let keyNome = "nome"
    static let keyTelefone = "telefone"
    static let keyIsBlocked = "is_blocked"
    static let keyIsLogged = "is_logged"
    static let keyRequestImage = "request_image"
    static let keySuccess = "success"
    static let keyError = "error"
    
    static let keyTag = "tag"
    static let keyRegister = "register"
    static let keyFindRequestTypes = "findRequestTypes"
    static let keyCheckUser = "checkUser"
    static let keyFindAldermen = "findAldermen"
    static let keySaveRequest = "saveRequest"
    static let keyLogin = "login"
    
    static let keyLatitude = "latitude"
    static let keyLongitude = "longitude"
    static let keyEndereco = "endereco"
    static let keyRequestType = "requestType"
    static let keyStatus = "status"
    
    // Params Camara
    static let getURLFindLastNoticia = URLCAMARA + "?secao=noticias&qtd=1&_pg=1&formato=json"
    static let getURLFindNoticia = URLCAMARA + "?secao=noticias&qtd=100&_pg=1&formato=json"
    
    // Params Rodolfo Ortale
    static let getBaseURL = URLRODOLFOORTALE
    
    static let getURLLogin = URLRODOLFOORTALE + "?tag=login"
    static let getURLSaveUser = URLRODOLFOORTALE + "?tag=register"
    
    static let getURLFindSolicitacao = URLRODOLFOORTALE + "?tag=findRequestTypes"
    static let getURLFindVereadores = URLRODOLFOORTALE + "?tag=findAldermen"
}
//
//  UsersController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import CoreData

protocol OnResultUserCallback {
    func onInitUser()
    
    func resultLoginCallback(nsData: NSDictionary)
    
    func resultLoginCallbackWithError(error: ErrorType)
    
    func resultSaveCallback(nsData: NSDictionary)
    
    func resultSaveCallbackWithError(error: ErrorType)
    
    func resultDataUserCallback(nsData: NSDictionary)
    
    func resultDataUserCallbackWithError(error: ErrorType)
}

class OnResultUserCallbackClass {
    var delegate:OnResultUserCallback?
    
    func onInitUser() {
        delegate?.onInitUser()
    }
    
    func resultLoginCallback(nsData: NSDictionary) {
        delegate?.resultLoginCallback(nsData)
    }
    
    func resultSaveCallback(nsData: NSDictionary) {
        delegate?.resultSaveCallback(nsData)
    }
    
    func resultDataUserCallback(nsData: NSDictionary) {
        delegate?.resultDataUserCallback(nsData)
    }
    
    func resultLoginCallbackWithError(error: ErrorType) {
        delegate?.resultLoginCallbackWithError(error)
    }
    
    func resultSaveCallbackWithError(error: ErrorType) {
        delegate?.resultSaveCallbackWithError(error)
    }
    
    func resultDataUserCallbackWithError(error: ErrorType) {
        delegate?.resultLoginCallbackWithError(error)
    }
}

class UsersController: NSObject, OnResultCallback, OnResultUserCallback {
    internal enum EnumAction : String {
        case Login          = "Login"
        case DataUser       = "DataUser"
        case Save           = "Save"
    }
    
    internal var enumAction: EnumAction!
    
    private var url = String()
    let onResultLoginCallbackClass = OnResultUserCallbackClass()
    
    private var user: User!
    
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    
    required init(url: String) {
        super.init()
        self.url = url
        onResultLoginCallbackClass.delegate = self
    }
    
    required override init() {
        
    }
    
    /*
     *   Função para cadastrar login
     */
    func save(user: User) {
        enumAction = EnumAction.Save
        
        let params = [
            HTTPCons.keyTag      : HTTPCons.keyRegister,
            HTTPCons.keyUser     : user.username,
            HTTPCons.keyPassword : user.password,
            HTTPCons.keyNome     : user.name,
            HTTPCons.keyTelefone : user.telefone
        ]
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    /*
     *   Função para verificar usuario
     */
    func checkUser(user: User) {
        enumAction = EnumAction.Save
        
        let params = [
            HTTPCons.keyTag  : HTTPCons.keyCheckUser,
            HTTPCons.keyUser : user.username
        ]
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    /*
     *   Função para efetuar login
     */
    func login(user: String, password: String) {
        enumAction = EnumAction.Login
        
        let params = [
            HTTPCons.keyTag      : HTTPCons.keyLogin,
            HTTPCons.keyUser     : user,
            HTTPCons.keyPassword : password
        ]
        
        let httpRequest = HTTPRequest(url: HTTPCons.getBaseURL)
        httpRequest.onResultCallbackClass.delegate = self
        httpRequest.connect(params)
    }
    
    func onInit() {
        self.onInitUser()
    }
    
    func onInitUser() {
        onResultLoginCallbackClass.onInitUser()
    }
    
    func resultCallback(nsData: NSDictionary) {
        //print(nsData)
        switch enumAction! {
        case EnumAction.Login:
            onResultLoginCallbackClass.resultLoginCallback(nsData)
            break;
            
        case EnumAction.DataUser:
            onResultLoginCallbackClass.resultDataUserCallback(nsData)
            break;
            
        case EnumAction.Save:
            onResultLoginCallbackClass.resultSaveCallback(nsData)
            break;
        }
    }
    
    func resultCallbackWithError(error: ErrorType) {
        //print(error)
        switch enumAction! {
        case EnumAction.Login:
            onResultLoginCallbackClass.resultLoginCallbackWithError(error)
            break;
            
        case EnumAction.DataUser:
            onResultLoginCallbackClass.resultDataUserCallbackWithError(error)
            break;
            
        case EnumAction.Save:
            onResultLoginCallbackClass.resultSaveCallbackWithError(error)
            break;
        }
    }
    
    func resultDataUserCallback(nsData: NSDictionary) {
        //print(nsData)
        onResultLoginCallbackClass.resultDataUserCallback(nsData)
    }
    
    func resultDataUserCallbackWithError(error: ErrorType) {
        print(error)
    }
    
    func resultLoginCallback(nsData: NSDictionary) {
        //print(nsData)
    }
    
    func resultLoginCallbackWithError(error: ErrorType) {
        print(error)
    }
    
    func resultSaveCallback(nsData: NSDictionary) {
        print(nsData)
    }
    
    func resultSaveCallbackWithError(error: ErrorType) {
        print(error)
    }
    
    func userExists() -> Bool {
        let appDel: AppDelegate = (UIApplication.sharedApplication()).delegate as! AppDelegate
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        var results = NSArray()
        
        do {
            results = try context.executeFetchRequest(request)
        }
        catch {
            print("Error loading user")
        }
        
        return results.count > 0
    }
    
    func selectUser() -> User {
        user = User()
        
        appDel = (UIApplication.sharedApplication()).delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let results: NSArray = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                let result = results[0] as! NSManagedObject
                
                user.id = result.valueForKey(HTTPCons.keyId) as! String
                user.username = result.valueForKey(HTTPCons.keyUser) as! String
                user.name = result.valueForKey(HTTPCons.keyNome) as! String
                user.isBlocked = result.valueForKey(HTTPCons.keyIsBlocked) as! Bool
                user.isLogged = result.valueForKey(HTTPCons.keyIsLogged) as? Bool
            }
        }
        catch {
            print("Error loading user")
        }
        
        return user
    }
    
    func insertUser(user: User) {
        if userExists() {
            deleteUser()
        }
        
        appDel = (UIApplication.sharedApplication()).delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context)
        newUser.setValue(user.id, forKey: HTTPCons.keyId)
        newUser.setValue(user.username, forKey: HTTPCons.keyUser)
        newUser.setValue(user.name, forKey: HTTPCons.keyNome)
        newUser.setValue(user.isBlocked, forKey: HTTPCons.keyIsBlocked)
        newUser.setValue(user.isLogged, forKey: HTTPCons.keyIsLogged)
        
        do {
            try context.save()
        }
        catch {
            print("Error to save the user")
        }
    }
    
    func deleteUser() {
        appDel = (UIApplication.sharedApplication()).delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let results: NSArray = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for result in results {
                    context.deleteObject(result as! NSManagedObject)
                }
            }
        }
        catch {
            print("Error loading user")
        }
    }
}

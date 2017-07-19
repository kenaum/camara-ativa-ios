//
//  CadastroViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/16/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController, OnResultUserCallback {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var btnDadosFacebook: UIButton!
    @IBOutlet weak var btnCadastrar: UIButton!
    
    var activeField: UITextField!
    
    var usersController: UsersController!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CadastroViewController.singleTapped(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.enabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CadastroViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CadastroViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        setViewStyle()
        setFielValuesForDebug()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setFielValuesForDebug() {
        if SwiftUtil.debug {
            txtEmail.text = "al@gmail.com"
            txtSenha.text = "teste1234"
            txtNome.text = "Al"
            txtTelefone.text = "6799887654"
        }
    }
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.orangeBackgroundColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.blueBackgroundColor
        
        viewUser.backgroundColor = SwiftUtil.orangeBackgroundColor
        btnDadosFacebook.backgroundColor = SwiftUtil.darkBlueBackgroundColor
        btnCadastrar.backgroundColor = SwiftUtil.orangeBackgroundColor
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        activeField = nil
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func launchaMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if textField == self.txtEmail {
            self.txtSenha.becomeFirstResponder()
        }
            
        else if textField == self.txtSenha {
            self.txtNome.becomeFirstResponder()
        }
            
        else if textField == self.txtNome {
            self.txtTelefone.becomeFirstResponder()
        }
            
        else if textField == self.txtTelefone {
            if (txtEmail.text?.isEmpty == false && txtSenha.text?.isEmpty == false && txtNome.text?.isEmpty == false && txtTelefone.text?.isEmpty == false) {
                if isValidatedForm() {
                    save()
                }
            }
        }
        
        return true
    }
    
    func iniciaConsulta(message: String) {
        SwiftUtil.showSpinner(message)
    }
    
    func isValidatedForm() -> Bool {
        if !SwiftValidator.isValidEmail(txtEmail.text!) || !SwiftValidator.isEmailInRange(txtEmail.text!) {
            let alertController = SwiftUtil.alertWarningCreator("Email inválido")
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
            
        else if txtSenha.text!.isEmpty {
            let alertController = SwiftUtil.alertWarningCreator("Senha inválida")
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
            
        else if txtNome.text!.isEmpty {
            let alertController = SwiftUtil.alertWarningCreator("Nome inválido")
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
            
        else if txtTelefone.text!.isEmpty {
            let alertController = SwiftUtil.alertWarningCreator("Telefone inválido")
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    func save() {
        user = User()
        
        user.username = txtEmail.text!
        user.password = txtSenha.text!
        user.name = txtNome.text!
        user.telefone = txtTelefone.text!
        
        usersController = UsersController()
        usersController.onResultLoginCallbackClass.delegate = self
        usersController.save(user)
    }
    
    func singleTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        let touches: Set<UITouch> = Set<UITouch>()
        super.touchesBegan(touches, withEvent: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func btnUsarDadosFacebook(sender: AnyObject) {
    }
    
    @IBAction func btnCadastrar(sender: AnyObject) {
        if isValidatedForm() {
            save()
        }
    }
    
    @IBAction func btnVoltar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onInitUser() {
        iniciaConsulta("Enviando dados...")
    }
    
    func resultLoginCallback(nsData: NSDictionary) {
    }
    
    func resultLoginCallbackWithError(error: ErrorType) {
    }
    
    func resultSaveCallback(nsData: NSDictionary) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let success: Bool = nsData.valueForKey(HTTPCons.keySuccess) as! Bool
            
            if success {
                let id: Int = nsData.valueForKey(HTTPCons.keyIdUser) as! Int
                
                let user = User()
                user.id = String(id)
                user.isLogged = true
                user.username = self.txtEmail.text!
                user.name = self.txtNome.text!
                user.isBlocked = false
                
                
                self.usersController = UsersController()
                self.usersController.insertUser(user)
                
                self.launchaMainVC()
            }
                
            else {
                let alertController = SwiftUtil.alertWarningCreator("Houve um erro ao cadastrar o usuário")
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func resultSaveCallbackWithError(error: ErrorType) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let alertController = SwiftUtil.alertWarningCreator("Houve um erro ao tentar cadastrar o usuário. Verifique sua conexão com a internet")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func resultDataUserCallback(nsData: NSDictionary) {
    }
    
    func resultDataUserCallbackWithError(error: ErrorType) {
    }
}

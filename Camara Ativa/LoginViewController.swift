//
//  ViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 28/03/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, OnResultUserCallback {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCadastrar: UIButton!
    
    private var activeField: UITextField!
    private var usersController: UsersController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.singleTapped(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.enabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
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
            txtEmail.text = "ortale22@gmail.com"
            txtSenha.text = "teste1234"
            
            //txtEmail.text = "teste"
            //txtSenha.text = "123456"
        }
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
    
    @IBAction func btnLogin(sender: AnyObject) {
        if isValidatedForm() {
            doLogin()
        }
    }
    
    func doLogin() {
        usersController = UsersController()
        usersController.onResultLoginCallbackClass.delegate = self
        usersController.login(txtEmail.text!, password: txtSenha.text!)
    }
    
    @IBAction func btnCadastrar(sender: AnyObject) {
        self.performSegueWithIdentifier("segueSobre", sender: self)
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
        
        return true
    }
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.navBarTintColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.navBarBackgroundColor
        
        viewUser.backgroundColor = SwiftUtil.orangeBackgroundColor
        btnLogin.backgroundColor = SwiftUtil.orangeBackgroundColor
        btnCadastrar.backgroundColor = SwiftUtil.darkBlueBackgroundColor
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
        
        if textField == self.txtSenha {
            if (txtEmail.text?.isEmpty == false && txtSenha.text?.isEmpty == false) {
                if isValidatedForm() {
                    doLogin()
                }
            }
        }
        
        return true
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
    
    func onInitUser() {
        iniciaConsulta("Verificando dados...")
    }
    
    func resultLoginCallback(nsData: NSDictionary) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let success: Bool = nsData.valueForKey(HTTPCons.keySuccess) as! Bool
            
            if success {
                let userData: NSDictionary = nsData.valueForKey(HTTPCons.keyUser) as! NSDictionary
                
                let id: String = userData.valueForKey(HTTPCons.keyId) as! String
                let username: String = userData.valueForKey(HTTPCons.keyUser) as! String
                let name: String = userData.valueForKey(HTTPCons.keyNome) as! String
                let isBlocked: Bool = userData.valueForKey(HTTPCons.keyIsBlocked) as! Bool
                
                let user = User()
                user.id = id
                user.username = username
                user.name = name
                user.isBlocked = isBlocked
                user.isLogged = true
                
                if !isBlocked {
                    // TODO: Salva no core data e vai pra principal
                    
                    self.usersController = UsersController()
                    self.usersController.insertUser(user)
                    
                    self.launchaMainVC()
                }
                    
                else {
                    let alertController = SwiftUtil.alertWarningCreator("Sua conta está bloqueada")
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
                
            else {
                let alertController = SwiftUtil.alertWarningCreator("Usuário ou senha inválidos")
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func resultLoginCallbackWithError(error: ErrorType) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let alertController = SwiftUtil.alertWarningCreator("Houve um erro ao tentar efetuar o login. Verifique sua conexão com a internet")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func resultSaveCallback(nsData: NSDictionary) {
        
    }
    
    func resultSaveCallbackWithError(error: ErrorType) {
        
    }
    
    func resultDataUserCallback(nsData: NSDictionary) {
        
    }
    
    func resultDataUserCallbackWithError(error: ErrorType) {
        
    }
}


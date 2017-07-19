//
//  SolicitacaoViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/22/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import CoreLocation

class SolicitacaoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, OnResultSolicitacaoCallback {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbSolicitacao: UILabel!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var btnLocalizar: UIButton!
    @IBOutlet weak var txtDemaisInformacoes: UITextView!
    @IBOutlet weak var btnVereadores: UIView!
    @IBOutlet weak var btnEnviar: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnTirarFoto: UIButton!
    
    private var activeField: UITextField!
    
    let locationManager = CLLocationManager()
    
    var lat = Double()
    var lng = Double()
    var requestType: RequestType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbSolicitacao.text = requestType.nomeSolicitacao
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SolicitacaoViewController.singleTapped(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.enabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SolicitacaoViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SolicitacaoViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
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
        
        if activeField != nil {
            if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.orangeBackgroundColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.blueBackgroundColor
        
        btnLocalizar.backgroundColor = SwiftUtil.orangeBackgroundColor
        btnEnviar.backgroundColor = SwiftUtil.orangeBackgroundColor
    }
    
    func setFielValuesForDebug() {
        if SwiftUtil.debug {
            txtEndereco.text = "Rua Napoleão Laureano, 389"
        }
    }
    
    @IBAction func btnLocalizar(sender: AnyObject) {
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func btnVoltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnEnviar(sender: AnyObject) {
        if isValidatedForm() {
            save()
        }
    }
    
    @IBAction func openCamera() {
        let alertController = UIAlertController(title: "Envio de imagem", message: "Escolha se deseja fotografar ou escolher uma foto da galeria.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Fotografar", style: UIAlertActionStyle.Default, handler: {
            Void in
            self.takePicture()
        }))
        alertController.addAction(UIAlertAction(title: "Escolher uma foto na minha galeria de imagens", style: UIAlertActionStyle.Default, handler: {
            Void in
            self.chooseImageFromGallery()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func save() {
        let solicitacoesController = SolicitacoesController()
        
        let solicitacao = Solicitacao()
        
        solicitacao.latitude = String(lat)
        solicitacao.longitude = String(lng)
        solicitacao.endereco = txtEndereco.text!
        solicitacao.requestType = requestType
        
        let requestStatus = RequestStatus()
        requestStatus.id = 2
        solicitacao.status = requestStatus
        
        let usersController = UsersController()
        let user = usersController.selectUser()
        solicitacao.user = user
        
        solicitacoesController.onResultSolicitacaoCallbackClass.delegate = self
        //let imageData:NSData = UIImagePNGRepresentation(self.imageView.image!)!
        //let strBase64:String = imageData.base64EncodedStringWithOptions([])
        solicitacoesController.saveRequest(solicitacao, imgBase64: nil)
    }
    
    func isValidatedForm() -> Bool {
        if txtEndereco.text!.isEmpty {
            let alertController = SwiftUtil.alertWarningCreator("Preencha o campo de endereço")
            presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateToLocation ", locations[0])
        let currentLocation: CLLocation = locations[0]
        
        lat = currentLocation.coordinate.latitude as Double
        lng = currentLocation.coordinate.longitude as Double
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) ->
            Void in
            if error != nil {
                print("Error: " + (error?.localizedDescription)!)
                return
            }
            
            else if placemarks?.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.displayLocationInfo(placemark)
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        self.txtEndereco.text = placemark.thoroughfare! + "," + placemark.subThoroughfare!
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didUpdateToLocationWithrror ", error.localizedDescription);
    }
    
    private func chooseImageFromGallery() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    private func takePicture() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //btnTirarFoto.imageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func iniciaConsulta(message: String) {
        SwiftUtil.showSpinner(message)
    }
    
    func onInitSolicitacao() {
        iniciaConsulta("Enviando solicitação. Por favor, aguarde.")
    }
    
    func resultSolicitacaoCallback(nsData: NSDictionary) {
        
    }
    
    func resultSolicitacaoCallbackWithError(error: ErrorType) {
        
    }
    
    func resultSaveSolicitacaoCallback(nsData: NSDictionary) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let success: Bool = nsData.valueForKey(HTTPCons.keySuccess) as! Bool
            
            if success {
                let alertController = UIAlertController(title: "Solicitação enviada.", message: "Sua solicitação foi enviada com sucesso.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    Void in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController")
                    self.presentViewController(viewController, animated: true, completion: nil)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
                
            else {
                let alertController = SwiftUtil.alertWarningCreator("Houve um erro ao enviar sua solicitação")
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func resultSaveSolicitacaoCallbackWithError(error: ErrorType) {
        dispatch_async(dispatch_get_main_queue()) {
            SwiftUtil.hideSpinner()
            
            let alertController = SwiftUtil.alertWarningCreator("Houve um erro ao enviar sua solicitação")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

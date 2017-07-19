//
//  VereadorConsultadoViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/13/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class VereadorConsultadoViewController: UIViewController {
    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbTelefone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var btnBiografia: UIButton!
    @IBOutlet weak var btnEnviar: UIButton!
    
    var vereador: Vereador!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ver = vereador
        
        lbTitulo.text = vereador.vereadorNome
        
        var strTelefone = ""
        for var i = 0; i < vereador.vereadorTelefone.count; i = i+1 {
            let telefone = vereador.vereadorTelefone[i].telefone
            strTelefone += telefone
            
            if i < vereador.vereadorTelefone.count - 1 {
                strTelefone += ","
            }
        }
        
        lbTelefone.text = strTelefone
        lbEmail.text = vereador.vereadorEmail
        lbWebsite.text = vereador.vereadorSite
        imgFoto.image = UIImage(named: vereador.vereadorFoto)
        
        setViewStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.orangeBackgroundColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.blueBackgroundColor
        
        btnBiografia.backgroundColor = SwiftUtil.orangeBackgroundColor
        btnEnviar.backgroundColor = SwiftUtil.orangeBackgroundColor
    }
    
    @IBAction func btnEnviar(sender: AnyObject) {
        let alertController = UIAlertController(title: "Mensagem enviada", message: "Sua mensagem foi enviada para o vereador.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController")
            self.presentViewController(viewController, animated: true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnBiografia(sender: AnyObject) {
        self.performSegueWithIdentifier("segueBiografia", sender: self)
    }
    
    @IBAction func btnSair(sender: AnyObject) {
    }
    
    @IBAction func btnVoltar() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueBiografia" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let biografiaViewController = navigationController.viewControllers.first as! BiografiaViewController
            
            biografiaViewController.biografia = vereador.vereadorBiografia
        }
    }
}

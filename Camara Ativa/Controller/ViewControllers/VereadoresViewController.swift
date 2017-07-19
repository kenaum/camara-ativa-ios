//
//  VereadoresViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/13/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class VereadoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OnResultVereadorCallback {
    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var listVereadores: UITableView!
    
    private var vereadoresList = [Vereador]()
    
    private var vereadoresController: VereadoresController!
    
    private var vereadorSelectionado: Vereador!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }
        
        setViewStyle()
        
        vereadoresController = VereadoresController()
        vereadoresController.onResultVereadorCallbackClass.delegate = self
        vereadoresController.getVereadores()
        
        let nibName = UINib(nibName: "VereadoresTableViewCell", bundle:nil)
        self.listVereadores.registerNib(nibName, forCellReuseIdentifier: "Cell")
    }
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.orangeBackgroundColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.blueBackgroundColor
        listVereadores.backgroundColor = SwiftUtil.blueBackgroundColor
    }
    
    func iniciaConsulta(message: String) {
        SwiftUtil.showSpinner(message)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let count = vereadoresList.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! VereadoresTableViewCell
        
        let vereador = vereadoresList[indexPath.row]
        
        cell.imgVereador?.image = UIImage(named: vereador.vereadorFoto)
        cell.lbNomeVereador?.text = vereador.vereadorNome
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //solicitacoesList[indexPath.row]
        vereadorSelectionado = vereadoresList[indexPath.row]
        self.performSegueWithIdentifier("segueVereador", sender: self)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = SwiftUtil.blueBackgroundColor
    }
    
    func onInitVereador() {
        iniciaConsulta("Consultando vereadores")
    }
    
    func finalizaConsulta() {
        SwiftUtil.hideSpinner()
    }
    
    func resultVereadorCallback(nsData: NSDictionary) {
        let vereadoresData: NSArray = nsData.valueForKey("aldermen") as! NSArray
        
        vereadoresList = [Vereador]()
        
        for var auxVereador in vereadoresData {
            let vereador = Vereador()
            
            let id: Int = Int(auxVereador.valueForKey("id") as! String)!
            let name: String = auxVereador.valueForKey("name") as! String
            let biografia: String = auxVereador.valueForKey("biografia") as! String
            let foto: String = auxVereador.valueForKey("foto") as! String
            let partido: String = auxVereador.valueForKey("partido") as! String
            let website: String = auxVereador.valueForKey("website") as! String
            let email: String = auxVereador.valueForKey("email") as! String
            
            vereador.id = id
            vereador.vereadorNome = name
            vereador.vereadorBiografia = biografia
            vereador.vereadorFoto = foto
            vereador.vereadorPartido = partido
            vereador.vereadorSite = website
            vereador.vereadorEmail = email
            
            var vereadorTelefoneList = [VereadorTelefone]()
            if let telefonesData: NSArray = auxVereador.valueForKey("phones") as! NSArray {
                for var auxTelefone in telefonesData {
                    let vereadorTelefone = VereadorTelefone()
                    
                    let phone: String = auxTelefone.valueForKey("phone") as! String
                    vereadorTelefone.telefone = phone
                    
                    vereadorTelefoneList.append(vereadorTelefone)
                }
            }
            
            vereador.vereadorTelefone = vereadorTelefoneList
            vereadoresList.append(vereador)
        }
        
        listVereadores.reloadData()
        finalizaConsulta()
    }
    
    func resultVereadorCallbackWithError(error: ErrorType) {
        
    }
    
    @IBAction func btnSair() {
        let usersController = UsersController()
        let user = usersController.selectUser()
        
        user.isLogged = false
        
        usersController.insertUser(user)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueVereador" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let vereadorConsultadoViewController = navigationController.viewControllers.first as! VereadorConsultadoViewController
            
            vereadorConsultadoViewController.vereador = vereadorSelectionado
        }
    }

}

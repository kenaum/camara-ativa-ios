//
//  NoticiasCamaraViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/11/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class NoticiasCamaraViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OnResultNoticiaCallback {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var listNoticias: UITableView!
    
    private var noticiasList = [Noticia]()
    
    private var noticiasController: NoticiasController!
    
    private var noticiaSelectionada: Noticia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }
        
        setViewStyle()
        
        noticiasController = NoticiasController()
        noticiasController.onResultNoticiaCallbackClass.delegate = self
        noticiasController.getNoticias()
        
        let nibName = UINib(nibName: "NoticiasCamaraTableViewCell", bundle:nil)
        self.listNoticias.registerNib(nibName, forCellReuseIdentifier: "Cell")
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
        listNoticias.backgroundColor = SwiftUtil.blueBackgroundColor
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
        let count = noticiasList.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NoticiasCamaraTableViewCell
        
        let noticia = noticiasList[indexPath.row]
        
        cell.lbData?.text = SwiftUtil.getBrazilianDateStringFormat(noticia.data)
        cell.lbNoticia?.text = noticia.titulo
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //solicitacoesList[indexPath.row]
        noticiaSelectionada = noticiasList[indexPath.row]
        self.performSegueWithIdentifier("segueNoticiaCamara", sender: self)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = SwiftUtil.blueBackgroundColor
    }
    
    func onInitNoticia() {
        iniciaConsulta("Consultando notícias")
    }
    
    func finalizaConsulta() {
        SwiftUtil.hideSpinner()
    }
    
    func resultNoticiaCallback(nsData: NSDictionary) {
        let noticiasData: NSArray = nsData.valueForKey("noticias") as! NSArray
        
        noticiasList = [Noticia]()
        
        for var auxNoticia in noticiasData {
            let noticia = Noticia()
            
            let id: Int = Int(auxNoticia.valueForKey("noticia_id") as! String)!
            let data: String = auxNoticia.valueForKey("data") as! String
            let titulo: String = auxNoticia.valueForKey("titulo") as! String
            let resumo: String = auxNoticia.valueForKey("resumo") as! String
            let link: String = auxNoticia.valueForKey("link") as! String
            
            noticia.noticia_id = id
            noticia.data = data
            noticia.titulo = titulo
            noticia.resumo = resumo
            noticia.link = link
            noticiasList.append(noticia)
        }
        
        listNoticias.reloadData()
        finalizaConsulta()
    }
    
    func resultNoticiaCallbackWithError(error: ErrorType) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueNoticiaCamara" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let noticiaConsultadaViewController = navigationController.viewControllers.first as! NoticiaConsultadaViewController
            
            noticiaConsultadaViewController.url = noticiaSelectionada.link
        }
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

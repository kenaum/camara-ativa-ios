//
//  SolicitacoesViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class SolicitacoesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OnResultSolicitacaoCallback {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var listSolicitacoes: UITableView!
    
    private var solicitacoesList = [RequestType]()
    private var requestType: RequestType!
    
    private var solicitacoesController: SolicitacoesController!

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
        
        solicitacoesController = SolicitacoesController()
        solicitacoesController.onResultSolicitacaoCallbackClass.delegate = self
        solicitacoesController.getSolicitacoes()
        
        let nibName = UINib(nibName: "SolicitacaoTableViewCell", bundle:nil)
        self.listSolicitacoes.registerNib(nibName, forCellReuseIdentifier: "Cell")
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
        listSolicitacoes.backgroundColor = SwiftUtil.blueBackgroundColor
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
        let count = solicitacoesList.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SolicitacaoTableViewCell
        
        let solicitacao = solicitacoesList[indexPath.row]
        
        cell.imgSolicitacao?.image = SwiftUtil.getIconStatus(solicitacao.imgSolicitacao)
        cell.lbSolicitacao?.text = solicitacao.nomeSolicitacao
        cell.lbDescricao?.text = solicitacao.descSolicitacao
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        requestType = solicitacoesList[indexPath.row]
        self.performSegueWithIdentifier("segueSolicitacao", sender: self)
    }
    
    func onInitSolicitacao() {
        iniciaConsulta("Consultando solicitações")
    }
    
    func finalizaConsulta() {
        SwiftUtil.hideSpinner()
    }
    
    func resultSolicitacaoCallback(nsData: NSDictionary) {
        let solicitacoesData: NSArray = nsData.valueForKey("request_types") as! NSArray
        
        solicitacoesList = [RequestType]()
        
        for var auxSolicitacao in solicitacoesData {
            let requestType = RequestType()
            
            let id: Int = Int(auxSolicitacao.valueForKey(HTTPCons.keyId) as! String)!
            let nome: String = auxSolicitacao.valueForKey(HTTPCons.keyNome) as! String
            let descricao: String = auxSolicitacao.valueForKey("descricao") as! String
            let icone: String = auxSolicitacao.valueForKey("icone") as! String
            
            requestType.solicitacao_id = id
            requestType.nomeSolicitacao = nome
            requestType.descSolicitacao = descricao
            requestType.imgSolicitacao = icone
            solicitacoesList.append(requestType)
        }
        
        listSolicitacoes.reloadData()
        finalizaConsulta()
    }
    
    func resultSolicitacaoCallbackWithError(error: ErrorType) {
        
    }
    
    func resultSaveSolicitacaoCallback(nsData: NSDictionary) {
        
    }
    
    func resultSaveSolicitacaoCallbackWithError(error: ErrorType) {
        
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
        if segue.identifier == "segueSolicitacao" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let solicitacaoViewController = navigationController.viewControllers.first as! SolicitacaoViewController
            
            solicitacaoViewController.requestType = requestType
        }
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

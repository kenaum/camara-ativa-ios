//
//  NoticiaConsultadaViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/12/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class NoticiaConsultadaViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var wvNoticia: UIWebView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        wvNoticia.loadRequest(request)
        
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
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        iniciaConsulta("Carregando notícia")
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SwiftUtil.hideSpinner()
    }
    
    func iniciaConsulta(message: String) {
        SwiftUtil.showSpinner(message)
    }
    
    @IBAction func btnSair(sender: AnyObject) {
    }
    
    @IBAction func btnVoltar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

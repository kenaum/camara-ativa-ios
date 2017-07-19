//
//  BiografiaViewController.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 5/16/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class BiografiaViewController: UIViewController {
    @IBOutlet weak var lbBiografia: UITextView!
    
    var biografia: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let str = try NSAttributedString(data: biografia.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            
            lbBiografia.attributedText = str
        } catch {
            //print(error)
        }
        
        setViewStyle()
    }
    
    func setViewStyle() {
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: SwiftUtil.navBarTextStyle]
        nav?.barTintColor = SwiftUtil.orangeBackgroundColor
        nav?.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = SwiftUtil.blueBackgroundColor
    }
    
    @IBAction func btnVoltar() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

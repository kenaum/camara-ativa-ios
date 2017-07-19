//
//  SwiftUtil.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 28/03/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit
import SVProgressHUD

class SwiftUtil {
    static let debug = false
    
    private static let alertSuccessTitle = "Sucesso"
    private static let warningSuccessTitle = "Ops"
    private static let errorSuccessTitle = "Erro"
    
    // Nav Bar style
    static let navBarTextStyle: UIColor = UIColor(netHex:0xFFFFFF)
    static let navBarTintColor: UIColor = UIColor(netHex:0x95a22)
    static let navBarBackgroundColor: UIColor = UIColor(netHex:0x95a22)
    
    // Border properties
    static let borderWidth: CGFloat = 1
    static let borderColor: CGColor = UIColor(netHex:0xE5E5E5).CGColor
    static let borderBackgroundColor: UIColor = UIColor(netHex:0xE5E5E5)
    
    // Clear background styles
    static let orangeBackgroundColor: UIColor = UIColor(netHex:0xe95a22)
    static let blueBackgroundColor: UIColor = UIColor(netHex:0xc0deff)
    static let darkBlueBackgroundColor: UIColor = UIColor(netHex:0x3275b9)
    
    // Gray Button Style
    static let transparenteUIColor: UIColor = UIColor(white: 1, alpha: 0.5)
    
    static func showSpinner(message: String) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.showWithStatus(message)
    }
    
    static func hideSpinner() {
        SVProgressHUD.dismiss()
    }

    static func alertSuccessCreator(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: alertSuccessTitle, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
    
    static func alertWarningCreator(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: warningSuccessTitle, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
    
    static func alertErrorCreator(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: errorSuccessTitle, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
    
    static func getIconStatus(status: String) -> UIImage! {
        return UIImage(named: status)!
    }
    
    static func getBrazilianDateStringFormat(date: String) -> String {
        let date = self.getDateFromUniversalFormatDateString(date)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    
    private static func getDateFromUniversalFormatDateString(date: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.dateFromString(date)
        
        return date!
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

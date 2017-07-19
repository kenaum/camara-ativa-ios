//
//  SwiftValidator.swift
//  Camara Ativa
//
//  Created by RODOLFO ORTALE on 4/19/16.
//  Copyright © 2016 Big Arte. All rights reserved.
//

import UIKit

class SwiftValidator: NSObject {
    static func isValidEmail(value: String) -> Bool {
        print("validate calendar: \(value)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = value.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    static func isEmailInRange(target: String) -> Bool {
        return target.characters.count >= 4; // && target.length() <= 20;
    }
}

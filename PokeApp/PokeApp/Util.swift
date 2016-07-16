//
//  Util.swift
//  PokeApp
//
//  Created by Damir Kopljar on 7/16/16.
//  Copyright © 2016 Damir Kopljar. All rights reserved.
//

import Foundation
struct Util {
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

}

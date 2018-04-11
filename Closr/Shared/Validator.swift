//
//  Validator.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-09-03.
//  Copyright © 2017 closr. All rights reserved.
//

import Foundation
import SwaggerClient

struct Validator {
    
    func validate(name: String?) -> (valid: Bool, message: String?) {
        guard let name = name, !name.isEmpty else {
            return (false, "Sorry name can not be empty")
        }
        
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard trimmed.count >= 2 else {
            return (false, "Please provide a valid name")
        }
        
        return (true, nil)
    }
    
    func validate(email: String?) -> (valid: Bool, message: String?) {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        return (result, result ? nil : "Please provide a valid email")
    }
    
    func validate(event: EventCreate) {
        
    }
}

//
//  NDFormProtocols.swift
//  NDForm
//
//  Created by Jun MeAol on 06/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit

/// Protocol for user defined validation objects
public protocol Validator {
    func validate(object: NDDataWrapper)
    static func validationError() -> NSError?
}

/// Protocol for form validation events
public protocol NDFormValidationDelegate {
    
    /**
     Method called when the form validation process completes
     
     - Parameter form: A reference to the current form
    */
    func didValidateForm(form: NDFormValidator)
}

public protocol NDValueToStringTransformer {
    func toString(value: AnyObject?) -> String
}
//
//  NDFormProtocols.swift
//  NDForm
//
//  Created by iAmNaz on 06/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit

/// Protocol for user defined validation objects
@objc public protocol NDValidator {
    func validate(_ object: NDDataWrapper)
    static func validationError() -> NSError?
}

/// Protocol for form validation events
@objc public protocol NDFormValidationDelegate {
    /**
     Method called when the form validation process completes
     
     - Parameter form: A reference to the current form
    */
    func didValidateForm(_ form: NDFormValidator)
}

@objc public protocol NDValueToStringTransformer {
    func toString(_ value: AnyObject?) -> String
}

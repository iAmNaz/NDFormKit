//
//  NDFormValidationRules.swift
//  NDForm
//
//  Created by iAmNaz on 06/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import Foundation

/// A required implementaion of the Validator protocol
public class NDRequired: NSObject, NDValidator {
    public func validate(object: NDDataWrapper) {
        if object.value() != nil {
            if !StringUtility.stringIsNotEmpty(object.value() as! String) {
                object.setValidationError(NDRequired.validationError()!)
            }
        }else{
            object.setValidationError(NDRequired.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Field is empty", failureReason: "Field is empty", recoverySuggestion: "Supply the required information")
    }
}

/// A not required class
public class NDNotRequired: NSObject, NDValidator {
    public func validate(object: NDDataWrapper) {

    }
    
    public class func validationError() -> NSError? {
        return nil
    }
}

/// Email format validation rule
public class NDEmail: NSObject, NDValidator {
    public func validate(object: NDDataWrapper) {
        if let val = object.value() {
            let validEmail = NDRegextUtility.isValidFormat("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", str: val as! String)
            
            if !validEmail {
                object.setValidationError(NDEmail.validationError()!)
            }
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Invalid format", failureReason: "Not a valid email", recoverySuggestion: "Enter a valid email")
    }
}

/// Minimum character length rule
public class NDMinimumLength: NSObject, NDValidator {
    var minLength: Int?
    
    public init(minimumLength: Int, validationError: NSError) {
        minLength = minimumLength
    }
    
    public func validate(object: NDDataWrapper) {
        let string : String = object.value() as! String
        if !(string.characters.count >= minLength) {
            object.setValidationError(NDMinimumLength.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Too short", failureReason: "Text entered is too short", recoverySuggestion: "Text must be this long")
    }
}

/// Maximum character length rule
public class NDMaximumLength: NSObject, NDValidator {
    var maxLength: Int?
    
    public init(maximumLength: Int) {
        maxLength = maximumLength
    }
    
    public func validate(object: NDDataWrapper) {
        let string : String = object.value() as! String
        if string.characters.count <= maxLength {
            object.setValidationError(NDMaximumLength.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Too Long", failureReason: "Text entered is too long", recoverySuggestion: "Text must be this long")
    }
}

///Exact length character rule
public class NDExactLength: NSObject, NDValidator  {
    var exactLength: Int?
    public init(expectedLength: Int) {
        exactLength = expectedLength
    }
    
    public func validate(object: NDDataWrapper) {
        if (object.value() as! String).characters.count == exactLength {
            object.setValidationError(NDExactLength.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Incorrect character length", failureReason: "Text entered either  shorter or longer than required", recoverySuggestion: "Text must be this long")
    }
}

/// Greater than value rule
public class NDGreaterThan: NSObject, NDValidator  {
    var greaterVal: Int?
    public init(greaterValue: Int) {
        greaterVal = greaterValue
    }
    
    public func validate(object: NDDataWrapper) {
        if Int(object.value() as! String)  > greaterVal! {
            object.setValidationError(NDGreaterThan.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Incorrect value", failureReason: "The number entered is not some value", recoverySuggestion: "Value must be...")
    }
}

/// Less than value rule
public class NDLessThan: NSObject, NDValidator  {
    var lessVal: Int?
    public init(lessValue: Int) {
        lessVal = lessValue
    }
    
    public func validate(object: NDDataWrapper) {
        if Int(object.value() as! String) < lessVal {
            object.setValidationError(NDLessThan.validationError()!)
        }
    }
    
    public class func validationError() -> NSError? {
        return createError("Incorrect value", failureReason: "The number entered is not some value", recoverySuggestion: "Value must be...")
    }
}

/// Only numeric validation rule
public class NDNumeric: NSObject, NDValidator  {
    public func validate(object: NDDataWrapper) {
        if Int(object.value() as! String) != nil {
            object.setValidationError(NDNumeric.validationError()!)
        }
    }
    public class func validationError() -> NSError? {
        return createError("Not numeric", failureReason: "The value entered is not numeric", recoverySuggestion: "Value must be numeric")
    }
}

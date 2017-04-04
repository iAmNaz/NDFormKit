//
//  NDFormValidationRules.swift
//  NDForm
//
//  Created by iAmNaz on 06/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


/// A required implementaion of the Validator protocol
open class NDRequired: NSObject, NDValidator {
    open func validate(_ object: NDDataWrapper) {
        if object.value() != nil {
            if !StringUtility.stringIsNotEmpty(object.value() as! String) {
                object.setValidationError(NDRequired.validationError()!)
            }
        }else{
            object.setValidationError(NDRequired.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Field is empty", failureReason: "Field is empty", recoverySuggestion: "Supply the required information")
    }
}

/// A not required class
open class NDNotRequired: NSObject, NDValidator {
    open func validate(_ object: NDDataWrapper) {

    }
    
    open class func validationError() -> NSError? {
        return nil
    }
}

/// URL format validation rule
open class NDURL: NSObject, NDValidator {
    open func validate(_ object: NDDataWrapper) {
        if let val = object.value() {
            let validEmail = NDRegextUtility.isValidFormat("\\w+:\\/\\/(([a-z0-9|-]+\\.*[a-z0-9|-]+\\.[a-z]+)|(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))(\\/)?(.+)?", str: val as! String)
            
            if !validEmail {
                object.setValidationError(NDEmail.validationError()!)
            }
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Invalid url", failureReason: "Not a valid url", recoverySuggestion: "Enter a valid url")
    }
}


/// Email format validation rule
open class NDEmail: NSObject, NDValidator {
    open func validate(_ object: NDDataWrapper) {
        if let val = object.value() {
            let validEmail = NDRegextUtility.isValidFormat("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", str: val as! String)
            
            if !validEmail {
                object.setValidationError(NDEmail.validationError()!)
            }
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Invalid format", failureReason: "Not a valid email", recoverySuggestion: "Enter a valid email")
    }
}

/// Minimum character length rule
open class NDMinimumLength: NSObject, NDValidator {
    var minLength: Int?
    
    public init(minimumLength: Int, validationError: NSError) {
        minLength = minimumLength
    }
    
    open func validate(_ object: NDDataWrapper) {
        let string : String = object.value() as! String
        if !(string.characters.count >= minLength) {
            object.setValidationError(NDMinimumLength.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Too short", failureReason: "Text entered is too short", recoverySuggestion: "Text must be this long")
    }
}

/// Maximum character length rule
open class NDMaximumLength: NSObject, NDValidator {
    var maxLength: Int?
    
    public init(maximumLength: Int) {
        maxLength = maximumLength
    }
    
    open func validate(_ object: NDDataWrapper) {
        let string : String = object.value() as! String
        if string.characters.count <= maxLength {
            object.setValidationError(NDMaximumLength.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Too Long", failureReason: "Text entered is too long", recoverySuggestion: "Text must be this long")
    }
}

///Exact length character rule
open class NDExactLength: NSObject, NDValidator  {
    var exactLength: Int?
    public init(expectedLength: Int) {
        exactLength = expectedLength
    }
    
    open func validate(_ object: NDDataWrapper) {
        if (object.value() as! String).characters.count == exactLength {
            object.setValidationError(NDExactLength.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Incorrect character length", failureReason: "Text entered either  shorter or longer than required", recoverySuggestion: "Text must be this long")
    }
}

/// Greater than value rule
open class NDGreaterThan: NSObject, NDValidator  {
    var greaterVal: Int?
    public init(greaterValue: Int) {
        greaterVal = greaterValue
    }
    
    open func validate(_ object: NDDataWrapper) {
        if Int(object.value() as! String)  > greaterVal! {
            object.setValidationError(NDGreaterThan.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Incorrect value", failureReason: "The number entered is not some value", recoverySuggestion: "Value must be...")
    }
}

/// Less than value rule
open class NDLessThan: NSObject, NDValidator  {
    var lessVal: Int?
    public init(lessValue: Int) {
        lessVal = lessValue
    }
    
    open func validate(_ object: NDDataWrapper) {
        if Int(object.value() as! String) < lessVal {
            object.setValidationError(NDLessThan.validationError()!)
        }
    }
    
    open class func validationError() -> NSError? {
        return createError("Incorrect value", failureReason: "The number entered is not some value", recoverySuggestion: "Value must be...")
    }
}

/// Only numeric validation rule
open class NDNumeric: NSObject, NDValidator  {
    open func validate(_ object: NDDataWrapper) {
        if Int(object.value() as! String) != nil {
            object.setValidationError(NDNumeric.validationError()!)
        }
    }
    open class func validationError() -> NSError? {
        return createError("Not numeric", failureReason: "The value entered is not numeric", recoverySuggestion: "Value must be numeric")
    }
}

//
//  NDFormPrivateUtilities.swift
//  NDForm
//
//  Created by Jun MeAol on 15/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import Foundation

let NDFormErrorDomain = "com.ndform.errors"

func errorInfo(description: String, failureReason: String, recoverySuggestion: String) -> [String: String] {
    let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString(description, comment: ""), NSLocalizedFailureReasonErrorKey : NSLocalizedString(failureReason, comment: ""), NSLocalizedRecoverySuggestionErrorKey : NSLocalizedString(recoverySuggestion, comment: "")]
    return userInfo
}

func createError(description: String, failureReason: String, recoverySuggestion: String) -> NSError {
    let errorDict = errorInfo(description, failureReason: failureReason, recoverySuggestion: recoverySuggestion)
    let error = NSError(domain: NDFormErrorDomain, code: -1, userInfo: errorDict)
    return error
}

/// Class for string specific utility methods
class StringUtility: NSObject {
    class func stringIsNotEmpty(str: String) -> Bool {
        let cleanString = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if cleanString.isEmpty {
            return false
        }
        return true
    }
}

/// Regular expression utility
class NDRegextUtility: NSObject {
    class func isValidFormat(regEx:String, str:String) -> Bool {
        let emailRegEx = regEx
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(str)
        return result
    }
}

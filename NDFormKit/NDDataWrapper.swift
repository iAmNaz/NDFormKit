//
//  NDDataWrapper.swift
//  NDForm
//
//  Created by iAmNaz on 01/01/2016.
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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



/**
 Field types to classify NDDataWrappers.
 Normally the field type corresponds with the type of input.
 */
@objc public enum NDFieldType : Int {
    case textType, textViewType, numericType, passwordType, passwordConfirmType, emailType, booleanType, calendarDateType, calendarTimeType, calendarDateTimeType, pickerType, multiSelectSubListType, subListType, photoType, urlType
    
        public func name () -> String {
            switch self {
                case .textType: return "TextType"
                case .textViewType: return "TextViewType"
                case .numericType: return "NumericType"
                case .passwordType: return "PasswordType"
                case .passwordConfirmType: return "PasswordConfirmType"
                case .emailType: return "EmailType"
                case .booleanType: return "BooleanType"
                case .calendarDateType: return "CalendarDateType"
                case .calendarTimeType: return "CalendarTimeType"
                case .calendarDateTimeType: return "CalendarDateTimeType"
                case .pickerType: return "PickerType"
                case .multiSelectSubListType: return "MultiSelectSubListType"
                case .subListType: return "SubListType"
                case .photoType: return "PhotoType"
                case .urlType: return "URLType"
        }
    }
    
}

/**
 A wrapper for existing values or values coming from the user.
 
 The intention is to have a uniform data structure and methods in managing values.
*/
open class NDDataWrapper: NSObject, NSCopying {
    /// Where to set the call back code which is called when field is validated
    open var wasValidated: ((_ valid: Bool) -> ())?
    /// A list of NDDataWrapper objects for list type fields
    open var subListValues: [NDDataWrapper]!
    /// An integer index for sorting operations
    open var index: Int!
    /// A NDFieldType type
    open var fieldType: NDFieldType = NDFieldType.textType
    /// The field's title
    open var fieldTitle: String!
    /// The field's title
    open var fieldPlaceholder = ""
    /// A unique string tag
    open var tag: String!
    /// Additional data that is related to the object value
    open var valueInfo: AnyObject?
    /// Getter for the required property
    open var isRequired: Bool! {
        return required
    }
    
    ///Prevent validation call when a value is set
    open var autoValidateWhenValueSet = true
    
    open var valueTransformer: NDValueToStringTransformer?
    
    override open var description: String {
        if self.value() != nil {
            return "\(self.fieldDisplayText): \(self.value()!)"
        }else{
            return "\(self.fieldDisplayText): nil)"
        }
    }
    
    fileprivate var fieldValue: AnyObject?
    fileprivate var fieldDisplayText = ""
    fileprivate var validationErrors:[NSError]?
    fileprivate var formValidator: NDFormValidator!
    fileprivate var required = false
    
    /**
        Initializes the data wrapper with initial property values.
     
         - Parameters:
             - tag: Object's tag
             - title: The field title
             - value: Object's value or nil
             - displayText: A text that represents the value
             - form: The form object
     */
    public init(tag: String!, title: String!, value: AnyObject?, form: NDFormValidator) {
        super.init()
        self.formValidator = form
        self.tag = tag
        self.fieldValue = value
        //TODO: dynamically set display text
        self.fieldTitle = title
    }
        
    override init() {
        super.init()
    }
    
    open func copy(with zone: NSZone?) -> Any {
        let copy = NDDataWrapper()
        copy.subListValues = self.subListValues
        copy.tag = self.tag
        copy.index = self.index
        copy.fieldType = self.fieldType
        copy.fieldTitle = self.fieldTitle
        copy.required = self.required
        copy.fieldValue = self.fieldValue
        copy.fieldDisplayText = self.fieldDisplayText
        return copy
    }
    
    //MARK: Field Error
    open func hasValidationErrors() -> Bool {
        if self.validationErrors != nil {
            return self.validationErrors?.count > 0
        }else{
            return false
        }
    }
    
    /**
     Returns a list of errors
     
     - Returns: An array of NSError
     */
    open func fieldValidationErrors() -> [NSError]? {
        return validationErrors
    }
    
    /**
     A setter for validation errors as NSError arrays
     */
    open func setValidationError(_ error: NSError) {
        if self.validationErrors != nil {
            self.validationErrors?.append(error)
        }else{
            self.validationErrors = [NSError]()
            self.validationErrors?.append(error)
        }
    }
    
    /**
     Used to quickly clear all errors
     */
    func clearValidationErrors() {
        self.validationErrors = nil
    }
    
    /**
     A method to access the value
     
     - Returns: The field value as AnyObject
     */
    open func value() -> AnyObject? {
        //return the copy instead???
        return fieldValue
    }
    
    /**
     Use to verify of the field value is set
     
     - Returns: Bool
     */
    open func filled() -> Bool {
        return fieldValue != nil
    }
    
    /**
     Data wrapper value setter
     */
    open func setValue(_ val: AnyObject?) {
        fieldValue = val
        if autoValidateWhenValueSet {
            formValidator.validate()
        }
    }
    
    /**
     Returns value formatted to string by a user provided transformer or the string value if value is a string
     - Returns: String
     */
    open func displayText() -> String {
        if value() != nil {
            if valueTransformer != nil {
                return valueTransformer!.toString(self.value()!)
            }else{
               return "\(value()!)"
            }
        }else{
            return ""
        }
    }
}

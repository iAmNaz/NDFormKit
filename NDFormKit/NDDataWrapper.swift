//
//  NDDataWrapper.swift
//  NDForm
//
//  Created by iAmNaz on 01/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import Foundation


/**
 Field types to classify NDDataWrappers.
 Normally the field type corresponds with the type of input.
 */
@objc public enum NDFieldType : Int {
    case TextType, TextViewType, NumericType, PasswordType, PasswordConfirmType, EmailType, BooleanType, CalendarDateType, CalendarTimeType, CalendarDateTimeType, PickerType, MultiSelectSubListType, SubListType, PhotoType
    
        public func name () -> String {
            switch self {
                case TextType: return "TextType"
                case TextViewType: return "TextViewType"
                case NumericType: return "NumericType"
                case PasswordType: return "PasswordType"
                case PasswordConfirmType: return "PasswordConfirmType"
                case EmailType: return "EmailType"
                case BooleanType: return "BooleanType"
                case CalendarDateType: return "CalendarDateType"
                case CalendarTimeType: return "CalendarTimeType"
                case CalendarDateTimeType: return "CalendarDateTimeType"
                case PickerType: return "PickerType"
                case MultiSelectSubListType: return "MultiSelectSubListType"
                case SubListType: return "SubListType"
                case PhotoType: return "PhotoType"
        }
    }
    
}

/**
 A wrapper for existing values or values coming from the user.
 
 The intention is to have a uniform data structure and methods in managing values.
*/
public class NDDataWrapper: NSObject, NSCopying {
    /// Where to set the call back code which is called when field is validated
    public var wasValidated: ((valid: Bool) -> ())?
    /// A list of NDDataWrapper objects for list type fields
    public var subListValues: [NDDataWrapper]!
    /// An integer index for sorting operations
    public var index: Int!
    /// A NDFieldType type
    public var fieldType: NDFieldType = NDFieldType.TextType
    /// The field's title
    public var fieldTitle: String!
    /// A unique string tag
    public var tag: String!
    /// Additional data that is related to the object value
    public var valueInfo: AnyObject?
    /// Getter for the required property
    public var isRequired: Bool! {
        return required
    }
    
    public var valueTransformer: NDValueToStringTransformer?
    
    override public var description: String {
        if self.value() != nil {
            return "\(self.fieldDisplayText): \(self.value()!)"
        }else{
            return "\(self.fieldDisplayText): nil)"
        }
    }
    
    private var fieldValue: AnyObject?
    private var fieldDisplayText = ""
    private var validationErrors:[NSError]?
    private var formValidator: NDFormValidator!
    private var required = false
    
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
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
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
    public func hasValidationErrors() -> Bool {
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
    public func fieldValidationErrors() -> [NSError]? {
        return validationErrors
    }
    
    /**
     A setter for validation errors as NSError arrays
     */
    public func setValidationError(error: NSError) {
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
    public func value() -> AnyObject? {
        //return the copy instead???
        return fieldValue
    }
    
    /**
     Use to verify of the field value is set
     
     - Returns: Bool
     */
    public func filled() -> Bool {
        return fieldValue != nil
    }
    
    /**
     Data wrapper value setter
     */
    public func setValue(val: AnyObject?) {
        fieldValue = val
        formValidator.validate()
    }
    
    /**
     Returns value formatted to string by a user provided transformer or the string value if value is a string
     - Returns: String
     */
    public func displayText() -> String {
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

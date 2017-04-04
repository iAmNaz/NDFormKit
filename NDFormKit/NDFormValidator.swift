//
//  NDFormValidator.swift
//  NDForm
//
//  Created by iAmNaz on 05/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit

/**
 Facilitates the validation of individual validation objects
 
 Form validation results can be handled by delegate objects conformating to the NDFormValidationDelegate protocol.
*/
open class NDFormValidator: NSObject {

    /// The form dataset used by the UITableView
    open var dataSet: NDFormDataSet!
    
    /// The form validation delegate
    open var delegate: NDFormValidationDelegate?
    
    /// A dictionary of assigned field validator objects
    open var fieldValidators: [String: [NDValidator]]!
    
    /// If form is completely valid after a validation run
    open var isValid: Bool {
        return formValid
    }
    
    /// Current validation state of the form
    open var formValid = false
    
    /// A dictionary of errors by data wrapper tags
    open var errors: [String : [NSError]]?
    
    /// Process validation on this queue
    fileprivate var formQueue: DispatchQueue!
    
    override public init() {
        super.init()
        initQueue()
    }
    
    /**
     Initializes and returns a NDFormValidator object with dataset and field validators
     
     - Parameter dataSet: A UITableView specific data structure
     - Parameter fieldValidators: A dictionary of field validators with keys associated to data set objects
     */
    public init(dataSet: NDFormDataSet, fieldValidators: [String: [NDValidator]]) {
        super.init()
        self.initQueue()
        self.fieldValidators = fieldValidators
        self.dataSet = dataSet
    }
    
    /**
     Invokes the validation process of all fields or values of object wrappers.
     
     The validation is processed on a different queue created upon initialization.
     
     Once the validation has completed the delegate methods are invoked
    */
    open func validate() {
        errors = [String : [NSError]]()
        formValid = true
        
        formQueue.sync { () -> Void in
            for section in self.dataSet.rows {
                for dataObj in section {
                    dataObj.clearValidationErrors()
                    
                    let validators = self.fieldValidators[dataObj.tag]!
                    for fieldValidator in validators {
                        self.validateField(dataObj, fieldValidator: fieldValidator)
                    }
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        //custom UI can be added to this block
                        dataObj.wasValidated?(!dataObj.hasValidationErrors())
                    })
                }
            }
        }
        delegate?.didValidateForm(self)
    }
    
    // Initializes the form queue
    fileprivate func initQueue() {
        formQueue = DispatchQueue(label: "com.ndform.form", attributes: [])
    }
    
    fileprivate func validateField(_ dataObj: NDDataWrapper, fieldValidator: NDValidator) {
        fieldValidator.validate(dataObj)
        
        if dataObj.hasValidationErrors() {
            errors![dataObj.tag] = dataObj.fieldValidationErrors()!
        }
        
        let hasErrors = dataObj.hasValidationErrors()
        formValid = formValid && !hasErrors
    }
}

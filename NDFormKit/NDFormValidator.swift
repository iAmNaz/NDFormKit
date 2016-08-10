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
public class NDFormValidator: NSObject {

    /// The form dataset used by the UITableView
    public var dataSet: NDFormDataSet!
    
    /// The form validation delegate
    public var delegate: NDFormValidationDelegate?
    
    /// A dictionary of assigned field validator objects
    public var fieldValidators: [String: [NDValidator]]!
    
    /// If form is completely valid after a validation run
    public var isValid: Bool {
        return formValid
    }
    
    /// Current validation state of the form
    public var formValid = false
    
    /// A dictionary of errors by data wrapper tags
    public var errors: [String : [NSError]]?
    
    /// Process validation on this queue
    private var formQueue: dispatch_queue_t!
    
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
    public func validate() {
        errors = [String : [NSError]]()
        formValid = true
        
        dispatch_sync(formQueue) { () -> Void in
            for section in self.dataSet.rows {
                for dataObj in section {
                    dataObj.clearValidationErrors()
                    
                    let validators = self.fieldValidators[dataObj.tag]!
                    for fieldValidator in validators {
                        self.validateField(dataObj, fieldValidator: fieldValidator)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //custom UI can be added to this block
                        dataObj.wasValidated?(valid: !dataObj.hasValidationErrors())
                    })
                }
            }
        }
        delegate?.didValidateForm(self)
    }
    
    // Initializes the form queue
    private func initQueue() {
        formQueue = dispatch_queue_create("com.ndform.form", nil)
    }
    
    private func validateField(dataObj: NDDataWrapper, fieldValidator: NDValidator) {
        fieldValidator.validate(dataObj)
        
        if dataObj.hasValidationErrors() {
            errors![dataObj.tag] = dataObj.fieldValidationErrors()!
        }
        
        let hasErrors = dataObj.hasValidationErrors()
        formValid = formValid! && !hasErrors
    }
}

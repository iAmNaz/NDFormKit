//
//  ViewController.swift
//  NDForm
//
//  Created by iAmNaz on 01/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import UIKit
import NDFormKit

//A user customized value transformer
class FormStringValueToStringTransformer: NSObject, NDValueToStringTransformer {
    func toString(_ value: AnyObject?) -> String {
        if value != nil {
            return value as! String
        }else{
            return ""
        }
    }
}

class ViewController: UIViewController, NDFormValidationDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var rows: NDFormDataSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hard coded bottom inset for the keyboard
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
        
        //A simple value transformer instantiated
        let valueTransformer = FormStringValueToStringTransformer()
        
        //A new form validator
        let formValidator = NDFormValidator()
        
        //Set this view controller as delegate
        formValidator.delegate = self
        
        //New dataset
        rows = NDFormDataSet()
        
        //Create the first section
        var section1 = [NDDataWrapper]()
        let r1 = NDDataWrapper(tag: "1", title: "First Name", value: nil, form: formValidator)
            r1.fieldType = NDFieldType.textType
            r1.valueTransformer = valueTransformer
        
        let r2 = NDDataWrapper(tag: "2", title: "Last Name", value: nil, form: formValidator)
            r2.fieldType = NDFieldType.textType
            r2.valueTransformer = valueTransformer
        
        let r3 = NDDataWrapper(tag: "3", title: "Password", value: nil, form: formValidator)
            r3.fieldType = NDFieldType.passwordType
            r1.valueTransformer = valueTransformer
        
        let r4 = NDDataWrapper(tag: "4", title: "Email", value: nil, form: formValidator)
            r4.fieldType = NDFieldType.emailType
            r4.valueTransformer = valueTransformer
        
        let r5 = NDDataWrapper(tag: "5", title: "Row5", value: nil, form: formValidator)
            r5.fieldType = NDFieldType.booleanType
            r5.valueTransformer = valueTransformer
        
        let r6 = NDDataWrapper(tag: "6", title: "Row6", value: nil, form: formValidator)
            r6.fieldType = NDFieldType.numericType
            r6.valueTransformer = valueTransformer
        
        let r7 = NDDataWrapper(tag: "7", title: "Row7", value: nil, form: formValidator)
            r7.fieldType = NDFieldType.numericType
            r7.valueTransformer = valueTransformer
        
        let r8 = NDDataWrapper(tag: "8", title: "Row8", value: nil, form: formValidator)
            r8.fieldType = NDFieldType.numericType
            r8.valueTransformer = valueTransformer
        
        let r9 = NDDataWrapper(tag: "9", title: "Row9", value: nil, form: formValidator)
            r9.fieldType = NDFieldType.numericType
            r9.valueTransformer = valueTransformer
        
        let r10 = NDDataWrapper(tag: "10", title: "Row10", value: nil, form: formValidator)
            r10.fieldType = NDFieldType.numericType
            r10.valueTransformer = valueTransformer
        
        let r11 = NDDataWrapper(tag: "11", title: "Ro11", value: nil, form: formValidator)
            r11.fieldType = NDFieldType.numericType
            r11.valueTransformer = valueTransformer
        
        let r12 = NDDataWrapper(tag: "12", title: "Row12", value: nil, form: formValidator)
            r12.fieldType = NDFieldType.numericType
            r12.valueTransformer = valueTransformer
        
        let r13 = NDDataWrapper(tag: "13", title: "Row13", value: nil, form: formValidator)
            r13.fieldType = NDFieldType.numericType
            r13.valueTransformer = valueTransformer
        
        let r14 = NDDataWrapper(tag: "14", title: "Row14", value: nil, form: formValidator)
            r14.fieldType = NDFieldType.numericType
            r14.valueTransformer = valueTransformer
        
        let r15 = NDDataWrapper(tag: "15", title: "Row15", value: nil, form: formValidator)
            r15.fieldType = NDFieldType.numericType
            r15.valueTransformer = valueTransformer
        
        let r16 = NDDataWrapper(tag: "16", title: "Row16", value: nil, form: formValidator)
            r16.fieldType = NDFieldType.numericType
            r1.valueTransformer = valueTransformer
        
        let r17 = NDDataWrapper(tag: "17", title: "Ro17", value: nil, form: formValidator)
            r17.fieldType = NDFieldType.numericType
            r17.valueTransformer = valueTransformer
        
        let r18 = NDDataWrapper(tag: "18", title: "Row18", value: nil, form: formValidator)
            r18.fieldType = NDFieldType.numericType
            r18.valueTransformer = valueTransformer
        
        section1.append(r1)
        section1.append(r2)
        section1.append(r3)
        section1.append(r4)
        section1.append(r5)
        section1.append(r6)
        section1.append(r7)
        section1.append(r8)
        section1.append(r9)
        section1.append(r10)
        section1.append(r11)
        section1.append(r12)
        section1.append(r13)
        section1.append(r14)
        section1.append(r15)
        section1.append(r16)
        section1.append(r17)
        section1.append(r18)
        
        rows.addSection(section1)
        
        //Create the validator
        //Validators are created and cached in a dictionary
        //A dictionary of meta from a backend server can be used to determine what types of 
        //field validator is required for each field
        var fieldValidators = [String: [NDValidator]]()

        //Create an instance of a required validation
        let requiredValidator = NDRequired()
        
        for section in rows.rows {
            for obj in section {
                fieldValidators[obj.tag] = [requiredValidator]
            }
        }
        
        //Use a different field validator for 4 & 5 objects
        fieldValidators["4"] = [NDRequired(), NDEmail()]
        fieldValidators["5"] = [NDNotRequired()]
        
        //Set the dataset to the dataset of the form
        formValidator.dataSet = rows.copy() as! NDFormDataSet
        
        //Set field validators
        formValidator.fieldValidators = fieldValidators
        
        //On viewDidLoad or viewWillAppear call validate to invoke the delegate teh first time
        //where the form UI could be dependent such as enable/disable the submit button
        formValidator.validate()
    }

    //Form delegate method
    func didValidateForm(_ form: NDFormValidator) {
        saveButton.isEnabled = form.isValid
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.numberOfObjectsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let rowObject = rows.objectAtIndexPath(indexPath)
        let cellKey = rowObject.fieldType
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellKey.name(), for: indexPath) as! NDFormTableViewCell
            cell.setFieldData(rowObject)
            cell.titleLabel?.text = rowObject.fieldTitle

        cell.titleLabel.textColor = UIColor.black
        
        let errorBaseFormat = { (hasError: Bool) -> () in
            if hasError {
                cell.titleLabel.textColor = UIColor.red
            }else{
                cell.titleLabel.textColor = UIColor.black
            }
        }
        //Format the title field if there is an error
        errorBaseFormat(rowObject.hasValidationErrors())

        //Display the value
        cell.setDisplayValue(rowObject)
        
        //Run any provided code as the field is validated
        rowObject.wasValidated = { (valid: Bool) -> () in
            errorBaseFormat(!valid)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    
}


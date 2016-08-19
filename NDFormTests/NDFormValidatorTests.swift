//
//  NDFormValidatorTests.swift
//  NDForm
//
//  Created by Naz Mariano on 19/08/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import XCTest
import NDFormKit

class NDFormValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    
    func testValidForm() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        field.setValue("http://www.google.com")
        
        XCTAssertTrue(formValidator.isValid)
    }
    
    func testInvalidValidForm() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        field.setValue("http//:www.google.com")
        
        XCTAssertFalse(formValidator.isValid)
    }
}

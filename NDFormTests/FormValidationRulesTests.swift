//
//  FormValidationRulesTests.swift
//  NDForm
//
//  Created by Naz Mariano on 19/08/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import XCTest
import NDFormKit

class FormValidationRulesTests: XCTestCase {

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidHttpURL() {
        let rows = NDFormDataSet()

        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("http://www.google.com")
        field.fieldType = NDFieldType.URLType
        

        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()

        XCTAssertFalse(field.hasValidationErrors())
    }
    
    func testInValidRTMPURL() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("rtmp//:www.google.com")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertTrue(field.hasValidationErrors())
    }
    
    func testValidRTMPURL() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("rtmp://www.google.com")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertFalse(field.hasValidationErrors())
    }
    
    func testValidRTMPIPURL() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("rtmp://192.168.1.1")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertFalse(field.hasValidationErrors())
    }
    
    func testValidURLWithPath() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("rtmp://192.168.1.1/live")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertFalse(field.hasValidationErrors())
    }
    
    func testValidURLWithUsernamePassword() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("rtmp://username:passwrod@192.168.1.1/live")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertTrue(field.hasValidationErrors())
    }
    
    func testInValidHttpURL() {
        let rows = NDFormDataSet()
        
        var section1 = [NDDataWrapper]()
        var fieldValidators = [String: [NDValidator]]()
        let formValidator = NDFormValidator()
        
        let field = NDDataWrapper(tag: "1", title: "Row7", value: nil, form: formValidator)
        field.setValue("http//:www.google.com")
        field.fieldType = NDFieldType.URLType
        
        
        section1.append(field)
        
        rows.addSection(section1)
        
        fieldValidators["1"] = [NDURL()]
        formValidator.dataSet = rows
        
        formValidator.fieldValidators = fieldValidators
        formValidator.validate()
        
        XCTAssertTrue(field.hasValidationErrors())
    }
}

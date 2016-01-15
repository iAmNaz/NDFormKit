//
//  NDFormTests.swift
//  NDFormTests
//
//  Created by iAmNaz on 11/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import XCTest
import NDFormKit

class StringValueToStringTransformer: NSObject, NDValueToStringTransformer {
    func toString(value: AnyObject?) -> String {
        if value != nil {
            return value as! String
        }else{
            return ""
        }
    }
}

class IntValueToStringTransformer: NSObject, NDValueToStringTransformer {
    func toString(value: AnyObject?) -> String {
        if value != nil {
            return "\(value!)"
        }else{
            return ""
        }
    }
}

class NDDataWrapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testInstanceNotNil() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        XCTAssertNotNil(object)
    }
    
    func testHasValidationErrors() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        let error = NSError(domain: "dm", code: 1, userInfo: nil)
        object.setValidationError(error)
        
        XCTAssertTrue(object.hasValidationErrors())
    }
    
    func testValidationErrorNil() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        XCTAssertNil(object.fieldValidationErrors())
    }
    
    func testValidationErrorNotNil() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        let error = NSError(domain: "dm", code: 1, userInfo: nil)
        object.setValidationError(error)
        
        XCTAssertNotNil(object.fieldValidationErrors())
    }
    
    func testReturnCorrectError() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        let error = NSError(domain: "dm", code: 1, userInfo: nil)
        object.setValidationError(error)
        
        XCTAssertEqual(object.fieldValidationErrors()!, [error])
    }
    
    func testValueIsNil() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: nil, form: form)
        XCTAssertNil(object.value())
    }
    
    func testValueIsNotNil() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: "1", form: form)
        XCTAssertNotNil(object.value())
    }
    
    func testValueIsTheSameAsSetValue() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: "1234", form: form)
        XCTAssertEqual(object.value() as? String, "1234")
    }
    
    func testValueIsNOTTheSameAsSetValue() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: "ABCD", form: form)
        XCTAssertNotEqual(object.value() as? String, "1234")
    }
    
    func testTestDisplayTextIsEquivalentString() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: 1, form: form)
        object.valueTransformer = IntValueToStringTransformer()
        XCTAssertEqual(object.displayText(), "1")
    }
    
    func testTestDisplayTextStringIsEquivalentString() {
        let form = NDFormValidator()
        let object = NDDataWrapper(tag: "1", title: "title", value: "A value", form: form)
        XCTAssertEqual(object.displayText(), "A value")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

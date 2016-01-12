//
//  NDFormDataSetTests.swift
//  NDForm
//
//  Created by Jun MeAol on 12/01/2016.
//  Copyright © 2016 locomoviles.com. All rights reserved.
//

import XCTest
import NDFormKit

class NDFormDataSetTests: XCTestCase {
    var dataSet: NDFormDataSet!
    var formValidator: NDFormValidator!
    var section1: [NDDataWrapper]!
    var r1: NDDataWrapper!
    
    override func setUp() {
        super.setUp()
        dataSet = NDFormDataSet()
        section1 = [NDDataWrapper]()
        
        formValidator = NDFormValidator()
        
        r1 = NDDataWrapper(tag: "1", title: "First Name", value: nil, form: formValidator)
        r1.fieldType = NDFieldType.TextType
        
        let r2 = NDDataWrapper(tag: "2", title: "Last Name", value: nil, form: formValidator)
        r2.fieldType = NDFieldType.TextType
        
        section1.append(r1)
        section1.append(r2)
        dataSet.addSection(section1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataSetNotNil() {
        XCTAssertNotNil(dataSet)
    }
    
    func testSection1IsSection1() {
        XCTAssertTrue(dataSet.getSection(0) == section1)
    }
    
    func test1SectionCount() {
        let sectionCount = dataSet.numberOfSections()
        XCTAssertTrue(sectionCount == 1)
    }
    
    func testFetchObjectIsSame() {
        XCTAssertEqual(r1, dataSet.objectAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)))
    }
    
    func testFetchObjectWithTag() {
        XCTAssertEqual(r1, dataSet.objectWithTag("1"))
    }
    
    func test2SectionCount() {
        var section2 = [NDDataWrapper]()
        let s1 = NDDataWrapper(tag: "12", title: "First Name", value: nil, form: formValidator)
        s1.fieldType = NDFieldType.TextType
        
        let s2 = NDDataWrapper(tag: "13", title: "Last Name", value: nil, form: formValidator)
        s2.fieldType = NDFieldType.TextType
        
        section2.append(s1)
        section2.append(s2)
        
        dataSet.addSection(section2)
        
        let sectionCount = dataSet.numberOfSections()
        XCTAssertTrue(sectionCount == 2)
    }
    
    func testSection1Has2Objects() {
        XCTAssertTrue(dataSet.numberOfObjectsInSection(0) == 2)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

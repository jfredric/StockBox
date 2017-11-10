//
//  StockBoxTests.swift
//  StockBoxTests
//
//  Created by Jared Sobol on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import XCTest
@testable import StockBox
import Firebase

class StockBoxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringTimmer() {
        let string1 = " HEY I JUST MEET YOU "
        let result2 = "HEY I JUST MEET YOU"
        let result1 = stringTrimmer(stringToTrim: string1)
        XCTAssertEqual(result1, result2)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDoubleToCurrency() {
        let doubleValue = 9.0
        let result1 = "$9.00"
        let result2 = doubleToCurrencyString(value: doubleValue)
        XCTAssertEqual(result1, result2)
    }
    
    func testTrimmedAndUnWrapped() {
        let string1 = "Hey"
        let string2 = "WhatsUP"
        let result1 = ("Hey", "WhatsUP")
        let result2 = trimmedAndUnwrappedTextFieldInputs(email: string1, password: string2)
        let tested = result1.0 == result2.0 && result1.1 == result2.1
        XCTAssertEqual(tested,true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

//
//  MarvelAPIDemoTests.swift
//  MarvelAPIDemoTests
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import XCTest
@testable import MarvelAPIDemo

class MarvelAPIDemoTests: XCTestCase {
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMarvelAPICall() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        vc.downloadComics() {
//            (status: String, attributionText: String, results: [AnyObject]) in
//            
//            XCTAssert(status == "Ok", "return status is not ok!")
//            XCTAssertNil(results, "results array is empty!")
//        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

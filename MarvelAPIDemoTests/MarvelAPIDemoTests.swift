//
//  MarvelAPIDemoTests.swift
//  MarvelAPIDemoTests
//
//  Created by Fadi Asfour on 2016-10-30.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import XCTest
@testable import MarvelAPIDemo

class MarvelAPIDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Check basic function all
    func testMarvelAPICall() {
        let limit = 10
        let offset = 0
        
        APICall().downloadComics(limit: limit, offset: offset) {
            (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
                XCTAssertTrue(results != nil, "results returned nil")
        }
    }
    
    /// Check that multiple calls can be made
    func testSubsequentMarvelAPICall() {
        
        let limit = 10
        var offset = 0
        let iterations = 10
        
        var comicList: [APIResult] = []
        
        
        for _ in (1...iterations) {
            
            let readyExpectation = expectation(description: "ready")
            
            APICall().downloadComics(limit: limit, offset: offset) {
                (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
                
                XCTAssertEqual(results!.count, limit, "returned results not equal to limit")
                XCTAssertEqual(data?.data?.offset!, offset, "local offset is not the same as API offset call")
                XCTAssertEqual(data?.data?.limit!, limit, "returned results not equal to asked limit")
                
                comicList += results!
                offset += (data?.data?.limit)!
        
                readyExpectation.fulfill()
                
            }
            
            waitForExpectations(timeout: 5, handler: {error in XCTAssertNil(error, "Error in expectation")})
        }
        
    }
    
    
    /// Check for duplicates in response data
    func testMarvelAPICallContainsNoDuplicateData() {
        
        let limit = 10
        var offset = 0
        let iterations = 10
        
        var comicList: [APIResult] = []
        var prevImport: [APIResult] = []
        var count = 1
        var idArray: [Int] = []
        
        for _ in (1...iterations) {
            
            let readyExpectation = expectation(description: "ready")
            
            APICall().downloadComics(limit: limit, offset: offset) {
                (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
                
                var newImport: [APIResult] = []
                
                for result in results! {
                    print("[\(count)] id: \(result.id!)")
                    
                    var duplicate = false
                    
                    for item in prevImport {
                        if result.id == item.id {
                            print("found duplicate for result.id:\(result.id)!")
                            duplicate = true
                        }
                    }
                    
                    if !duplicate {
                        newImport.append(result)
                        idArray.append(result.id!)
                        count += 1
                    }
                }
                
                comicList += newImport
                
                XCTAssertEqual(results!.count, limit, "returned results not equal to limit")
                XCTAssertEqual(data?.data?.offset!, offset, "local offset is not the same as API offset call")
                XCTAssertEqual(data?.data?.limit!, limit, "returned results not equal to asked limit")
                
                
                offset += (data?.data?.count)!
                
                XCTAssertEqual(comicList.count, idArray.count, "appended array is not increasing correctly")
                
                // copy response array to previous imported array
                prevImport = results!
                
                readyExpectation.fulfill()
                
            }
            
            waitForExpectations(timeout: 5, handler: {error in XCTAssertNil(error, "Error in expectation")})
        }
        
        print("Made \(limit * iterations) calls and received \(comicList.count) results ")
        
        let uniques = Set<Int>(idArray)
        let trimmed = Array<Int>(uniques)
        print("idArray.count: \(idArray.count), trimmed.count: \(trimmed.count)")
        
        XCTAssertEqual(idArray.count, trimmed.count, "Results have \(idArray.count - trimmed.count) duplicates ")
        
    }

    
}

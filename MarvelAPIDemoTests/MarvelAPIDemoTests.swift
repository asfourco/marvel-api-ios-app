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
    
    func testMarvelAPICall() {
        let limit = 10
        let offset = 0
        
        var comicList: [APIResult] = []
        
        APICall().downloadComics(limit: limit, offset: offset) {
            (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
    
            comicList += results!
            
            XCTAssertNil(results)
            XCTAssertNil(comicList)
            
        }
    }
    
    func testSubsequentMarvelAPICall() {
        
        let limit = 10
        var offset = 0
        let iterations = 10
        
        var comicList: [APIResult] = []
        
        for i in (0..<iterations) {
            
            APICall().downloadComics(limit: limit, offset: offset) {
                (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
                
                comicList += results!
                offset += (data?.data?.limit)!
                
                XCTAssertEqual(data?.data?.limit!, limit, "returned results not equal to asked limit")
                XCTAssertEqual(offset, limit * i+1, "offset is not incrementing properly")
                XCTAssertEqual(data?.data?.offset!, offset, "local offset is not the same as API offset call")
                XCTAssertEqual(results!.count, 10, "returned results not equal to limit")
                XCTAssertEqual(comicList.count, offset, "appended array is not increasing correctly")
                
            }
        }
        
    }
}

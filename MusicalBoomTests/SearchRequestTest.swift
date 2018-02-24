//
//  SearchRequestTest.swift
//  MusicalBoomTests
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import XCTest

@testable import MusicalBoom

final class SearchRequestTest: XCTestCase {
    
    var sut: SearchRequest!
    
    override func setUp() {
        super.setUp()
        sut = SearchRequest(name: "test.name")
    }
    
    func testProperties() {
        XCTAssertEqual(sut.path, "/database/search")
        XCTAssertEqual(sut.method, .GET)
    }
    func testQuery() {
        var query: [String : APIQueryParameter] {
            return ["q" : .string("test.name"),
                    "type" : .string("artist")
            ]
        }
        
        XCTAssertEqual(sut.query, query)
    }
}

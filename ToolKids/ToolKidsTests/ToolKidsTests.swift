//
//  ToolKidsTests.swift
//  ToolKidsTests
//
//  Created by Doan Ngoc Hung on 9/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import XCTest
@testable import ToolKids

class ToolKidsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let result = "{\"key\": \"d8daf3fb00d640e5\", \"ip\": [65, 45, 52, 48], \"rnd\": \"76CEA973-D5D\", \"sn\": 164, \"fid\": \"x1\", \"sid\": \"1505990729175881\", \"iv\": \"d8e6a47fa02449e0\"}"
        var token = result.components(separatedBy: "[")
        var s = token[1].components(separatedBy: "]")
        print(token[0])
        print(s[1])
        
        let a = token[0] + "0" + s[1]
        
        let mc = ViewController()
        
       let k = mc.convertToDictionary(text: a)
        
        print("aadaasasasasasas" + String(describing: k?["key"]!))
    
        print(a)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

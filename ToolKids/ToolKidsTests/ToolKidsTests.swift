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
        var dict : Dictionary<String, String> = [:]
        
        dict["ptuid"] = "device_info.ptuid"
        dict["akey"] = "device_info.akey"
        dict["sn"] = "device_info.sn"
        dict["imei"] = "device_info.imei"
        dict["iccid"] = "device_info.imei"
        dict["imsi"] = "device_info.imei"
        dict["rnd"] = "device_info.rnd"
        dict["mcc"] = "device_info.mcc"
        dict["mnc"] = "device_info.mnc"
        dict["cdma_tid"] = "device_info.cdma_tid"
        dict["uimid"] = "device_info.uimid"
        dict["esn"] = "device_info.esn"
        dict["meid"] = "device_info.meid"
        dict["area_cod"] = "device_info.area_code"
        
        
        do{
            
            var error : NSError?
            
            let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            
            print("aaaaa" + jsonString)
        
        }catch{
            
        }
        
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

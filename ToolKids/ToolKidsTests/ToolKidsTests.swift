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

        let urls = "http://10.20.1.7:4000/api/get-all-restaurent"
        
        var request = URLRequest(url : URL(string: urls)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")// kieu du lieu truyen len server
        request.addValue("access_token 939380ba-1f34-4e2b-84ee-019ae2a7cc7b", forHTTPHeaderField: "Authorization")// them xac thuwc vao header
        request.httpMethod = "POST"// phuong thuc truyen
        let json  = ["group_id":1] //data truyen len server
        let jsonData = try? JSONSerialization.data(withJSONObject: json)// convert data sang dang json
        
        request.httpBody = jsonData // add data vao body
        do{
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary // get data trar ve khi data tra ve laf mot json object
                print(json)
                
            } catch {
                print(error)
            }
        }
        task.resume()
        }catch{
            print(error)
        
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

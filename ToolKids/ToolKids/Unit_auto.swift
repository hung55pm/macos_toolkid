//
//  Unit_auto.swift
//  ToolKids
//
//  Created by hungdn on 9/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation

class Unit_auto: Any {
    

    func autoincrementptuid(str : String) ->String{
        
        //get string firt to index n
        let startIndex = str.index(str.startIndex, offsetBy: 3)
        let firt = str.substring(to: startIndex)
        print(firt)
        // get string from n -> end string
        let endIndex = str.index(str.startIndex, offsetBy: 7)
        let affter = str.substring(from: startIndex)
        
        print(affter)
        
        var  so = generateAkeyhextoint(strhex: affter)
        print(so)
        so = so+1
        print(so)
        
        let moi = generateAkeyinttohex(so: so)
        
        return firt + moi
    }
    
    func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = (range.upperBound - range.lowerBound + 1).toIntMax()
        let value = arc4random().toIntMax() % length + range.lowerBound.toIntMax()
        return T(value)
    }
    
    func autogenerateAkeyinttohex() -> String {
        let a = randomNumber(inRange: 10485760...16777215)
        var strhex = String(format:"%2x", a)
        return strhex
    }
    
    func generateAkeyinttohex(so : Int64) -> String {
        var strhex = String(format:"%2x", so)
        return strhex
    }
    
    func generateAkeyhextoint(strhex : String) -> Int64{
        var result = UInt64(strhex, radix:16)!
        return Int64(result)
    }
    

}

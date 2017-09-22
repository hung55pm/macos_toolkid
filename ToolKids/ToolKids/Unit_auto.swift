//
//  Unit_auto.swift
//  ToolKids
//
//  Created by hungdn on 9/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation

class Unit_auto: Any {
    
    
    func getthreefirt(str :String) -> String {
        let startIndex = str.index(str.startIndex, offsetBy: 3)
        let firt = str.substring(to: startIndex)
    return firt
    }
    
    func getfiveafter(str : String) -> String {
        let endIndex = str.index(str.startIndex, offsetBy: 3)
        let affter = str.substring(from: endIndex)
        
        return affter
    }

    func autoincrementptuid(str : String) ->String{
        
       
        let firt = getthreefirt(str: str)
        print(firt)

        let affter = getfiveafter(str: str)
        print(affter)
        
        var  so = generateAkeyhextoint(strhex: affter)
        print(so)
        so = so+1
        print(so)
        
        var moi = generateAkeyinttohex(so: so)
        moi = moi.replacingOccurrences(of: " ", with: "")
        print(moi.characters.count)
        if(moi.characters.count<5){
            for i in 1...(5 - moi.characters.count){
                moi = "0" + moi
                print("moi " + String(i) + moi)
            }
        }
        
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

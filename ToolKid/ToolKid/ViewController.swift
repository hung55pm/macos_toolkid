//
//  ViewController.swift
//  ToolKid
//
//  Created by Doan Ngoc Hung on 9/18/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Cocoa
import SharkORM
import CryptoSwift

class ViewController: NSViewController {
    
    
    @IBOutlet weak var combobox_choose_server: NSComboBox!
    
    @IBOutlet weak var combobox_choose_customer: NSComboBox!
    
    @IBAction func bt_choose_server(_ sender: Any) {
            }
    
    @IBAction func bt_choose_customer(_ sender: Any) {
    }
    
    @IBOutlet weak var Ed_imei: NSTextField!
    @IBOutlet weak var Ed_ptuid: NSTextField!
    @IBOutlet weak var Ed_akey: NSTextField!
    @IBOutlet weak var check_ptuid: NSButton!
    @IBOutlet weak var check_akey: NSButton!
    
    
    @IBOutlet weak var Ed_MCC: NSTextField!
    @IBOutlet weak var Ed_MNC: NSTextField!
    @IBOutlet weak var Ed_CDMA_TID: NSTextField!
    @IBOutlet weak var Ed_UIMID: NSTextField!
    @IBOutlet weak var Ed_ESN: NSTextField!
    @IBOutlet weak var Ed_MEID: NSTextField!
    @IBOutlet weak var Ed_AREA: NSTextField!
    @IBOutlet weak var Ed_change_server: NSTextField!
    @IBOutlet weak var Ed_change_port: NSTextField!
    
    
    
    @IBAction func bt_generate(_ sender: Any) {
        print(combobox_choose_server.indexOfSelectedItem)
        print(combobox_choose_customer.indexOfSelectedItem)
        
        
        switch check_ptuid.state {
        case NSOnState:
            print("on ptuid")
        case NSOffState:
            print("off ptuid")
        default:
            print("mixed")
        }
        
        
        switch check_akey.state {
        case NSOnState:
            print("on akey")
        case NSOffState :
            print("off akey")
        default:
            print("default")
        }
        
    }
    
    @IBAction func bt_change_server(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaddata()
        Ed_akey.stringValue = autogenerateAkeyinttohex()
        
        Ed_ptuid.stringValue = autoincrementptuid(str: "c9f222aefffff")
        
        //httpconnecserver()
        
        //connect()
        

    }
    func autoincrementptuid(str : String) ->String{
        
        //get string firt to index n
        let startIndex = str.index(str.startIndex, offsetBy: 4)
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
        
        return firt + "" + moi
    }

    func Aesencrypt(){
        
        let textString = "abcdef123456"
        let textData = textString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let textBytes:[UInt8] = textData.bytes
        
        
//            if let aes = AES(key: "QHTLklka%k!)825asa2svgi2qpc%(!", iv:"", blockMode: .ECB){
//            let encryptedData = aes.encrypt(textBytes, padding: PKCS7())
//        }
        
        do {
            
             let aes = try AES(key: "QHTLklka%k!)825asa2svgi2qpc%(!", iv:textString, blockMode: .ECB, padding: PKCS7())
            let encryptedData = try aes.encrypt(textBytes)
            
            
//            let aes = try AES(key: textString, iv: textString, blockMode: .ECB, padding: PKCS7())
//            let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
        } catch { }
        
        
    }
    
    override var representedObject: Any? {
        didSet {

        
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addserversegue"){
            let second = segue.destinationController as! AddNewServer
            second.representedObject  = combobox_choose_server
        }else if(segue.identifier == "addcustomersegue"){
            
            let second = segue.destinationController as! AddNewCustomers
            second.representedObject  = combobox_choose_customer
            
        }
        
        
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
    
    func loaddata() {
        var arrayserver: Array<SeverVinnet> = Array<SeverVinnet>()
        let rs: SRKResultSet = SeverVinnet.query().fetch()
        for var item001 in rs{
            var new01 = SeverVinnet()
            new01.domain = (item001 as! SeverVinnet).domain
            new01.port = (item001 as! SeverVinnet).port
            new01.user = (item001 as! SeverVinnet).user
            new01.pass = (item001 as! SeverVinnet).pass
            
            
            arrayserver.append(new01)
        }
        
        for i in (0..<arrayserver.count){
            combobox_choose_server.addItem(withObjectValue: arrayserver[i].domain)
        }
        
        
        var arraycus: Array<CustomerVinnet> = Array<CustomerVinnet>()
        let rscus: SRKResultSet = CustomerVinnet.query().fetch()
        for var item001 in rscus{
            var new01 = CustomerVinnet()
            new01.name = (item001 as! CustomerVinnet).name
            new01.key = (item001 as! CustomerVinnet).key

            
            arraycus.append(new01)
        }
        
        for i in (0..<arrayserver.count){
            combobox_choose_customer.addItem(withObjectValue: arraycus[i].name)
        }
        
    }
    func httpconnecserver(){
        
        
        let urls = "http://117.0.38.37:8259/api/Investor/changePassword"
       
        var request = URLRequest(url : URL(string: urls)!)
        
        request.httpMethod = "PUT"// phuong thuc truyen
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "investorId=DEMO000&oldPassword=Test1234&newPassword=dssdsds"//
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            
            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            print("responseString = \(responseString!)")
                    }
        task.resume()
        }
    
    
}


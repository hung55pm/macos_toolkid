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
    var t: String?
    var sid_sv : String?
    var iv_sv :String?
    var Key_sv :String?
    var sn_sv :String?
    var rnd_sv :String?
    
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
        
        httpconnecserver()
        
    }
    
    @IBAction func bt_change_server(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaddata()
        //Ed_akey.stringValue = autogenerateAkeyinttohex()
        
        //Ed_ptuid.stringValue = autoincrementptuid(str: "c9f222aefffff")
        
        //httpconnecserver()
        
       

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
        
        let FACTORY_KEY : String! = "czy7d125jlvmi8gf0qt4"
        
        
        let offset = Int(arc4random_uniform(UInt32(FACTORY_KEY.characters.count)))
        
        print("offset:  " + String(offset))
        
        let index1 = FACTORY_KEY.index(FACTORY_KEY.startIndex, offsetBy: offset)
        
        
        let substring1 = FACTORY_KEY.substring(to: index1)
        print("substring1:  " + substring1)
        
        let substring2 = FACTORY_KEY.substring(from: index1)
        print("substring2:  " + substring2)
        
        let key_firt : String! = String(substring2 + substring1)
        let index3 = key_firt.index(key_firt.startIndex, offsetBy: 16)
        let key :String! = key_firt.substring(to: index3)
        print("key:  " + key)
        
        
        let uuid = UUID().uuidString
        print("uuid:  " + uuid)
        
        let index2 = uuid.index(uuid.startIndex, offsetBy: 16)
        
        let req = uuid.substring(to: index2)
        print("req:  " + req)
        
        
        do {
            let aes = try AES(key: key!, iv: "", blockMode: .ECB, padding: NoPadding())
            let aes_req = try aes.encrypt([UInt8](req.utf8))
            let aes_text = aes_req.toHexString()
            
            print("aes_text:  " + String(aes_text.characters.count))
            
            let hmac_req = try HMAC(key: FACTORY_KEY, variant: .sha1).authenticate([UInt8](req.utf8))
            let hmac_cal = hmac_req.toHexString()
            print("hmac_cal:  " + hmac_cal)
            t = aes_text + hmac_cal
            
        } catch {
            
        }
        
        let FACTORY_ID :String? = "x1"
        let srtoff : String? = String(offset)
        
        let urls = "http://vinnet.vn:8005/fac_init"
        
        var request = URLRequest(url : URL(string: urls)!)
        request.httpMethod = "POST"// phuong thuc truyen
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "&fid=" + FACTORY_ID! + "&o=" + srtoff! + "&t=" + t!
        
        print("bodydata:  " + bodyData)
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            
            
            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            
            print("responseString = \(responseString!)")
            
            do{
                let res_aes = try AES(key: key!, iv: "", blockMode: .ECB, padding: NoPadding())
                let bytes = Array<UInt8>(hex: responseString!)
                let decrypted = try res_aes.decrypt(bytes)
                let characters = decrypted.map { Character(UnicodeScalar($0)) }
                let result = String(Array(characters))
                let a = "[" + result + "]"
                print(result)
               // print(a)
                
           
              
                var token = result.components(separatedBy: "[")
                var s = token[1].components(separatedBy: "]")
                print(token[0])
                print(s[1])
                let res = token[0] + "0" + s[1]
                print(res)
             let b = self.convertToDictionary(text: res)
            print(b)
            
            }catch{
            }
            
            
        }
        task.resume()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
}


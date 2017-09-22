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
    var sn_sv :Int64?
    var rnd_sv :String?
    let sql = Connectsqlite3()
    let csever = ConnecttoServer()
    let unit_auto = Unit_auto()
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
    @IBAction func check_ptuid(_ sender: Any) {
    }
    @IBAction func check_akey(_ sender: Any) {
        
        switch check_akey.state {
        case NSOnState:
            Ed_akey.stringValue = unit_auto.autogenerateAkeyinttohex()
            print("on akey")
        case NSOffState :
            Ed_akey.stringValue = ""
            print("off akey")
        default:
            print("default")
            
            
        }
        
    }
    
    
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
        aaaaaa()
                
        let Id : Int? = (combobox_choose_server.indexOfSelectedItem + 1)
        
        print(combobox_choose_customer.indexOfSelectedItem)
        
        
        if(Ed_imei.stringValue.characters.count<10 || Ed_ptuid.stringValue.characters.count<8 || Ed_akey.stringValue.characters.count<6){
            if(Ed_imei.stringValue.characters.count<10 ){
                
            }
            if(Ed_ptuid.stringValue.characters.count<8){
                
                print("ptuid phai la 8 ky tu")
                
            }
            if(Ed_akey.stringValue.characters.count<6){
                
                
                
            }
        
        }else{
            switch check_ptuid.state {
            case NSOnState:
                Ed_ptuid.stringValue = unit_auto.autoincrementptuid(str: Ed_ptuid.stringValue)
            case NSOffState:
                Ed_ptuid.stringValue = ""
                print("off ptuid")
            default:
                print("mixed")
            }
            
            switch check_akey.state {
            case NSOnState:
                Ed_akey.stringValue = unit_auto.autogenerateAkeyinttohex()
                print("on akey")
            case NSOffState :
                Ed_akey.stringValue = ""
                print("off akey")
            default:
                print("default")
                
                
            }
            
            if(Id! > 0){
                 let csever = ConnecttoServer()
                let server = sql.getseverbyId(Id: Id!)
                let reslogin = httpconnecserver(FACTORY_ID: server.user!, FACTORY_KEY: server.pass!, domain: server.domain!, port: server.port!)

                    //csever.httpconnecserver(FACTORY_ID: server.user!, FACTORY_KEY: server.pass!, domain: server.domain!, port: server.port!)
                sid_sv = reslogin.sid
                iv_sv = reslogin.iv
                Key_sv = reslogin.Key
                rnd_sv = reslogin.rnd
                sn_sv = reslogin.sn
                
                
                
                
                        var device = Device_Info()
                
                        device.akey = Ed_akey.stringValue
                        device.ptuid = Ed_ptuid.stringValue
                        device.imei = Ed_imei.stringValue
                        device.mcc = Ed_MCC.stringValue
                        device.mnc = Ed_MNC.stringValue
                        device.cdma_tid = Ed_CDMA_TID.stringValue
                        device.uimid = Ed_UIMID.stringValue
                        device.esn = Ed_ESN.stringValue
                        device.meid = Ed_MEID.stringValue
                        device.area_code = Ed_AREA.stringValue
                        print(reslogin.sn)
                        device.sn = reslogin.sn! + 1
                        device.rnd = reslogin.rnd
                        device.iccid = ""
                        device.imsi = ""
                        
                    csever.genQRcode(sever: server, reslogin: reslogin, device_info: device)
            }
            

        }
    
       
        
        

        
    }
    
    func httpconnecserver(FACTORY_ID : String, FACTORY_KEY :String , domain : String , port :String) -> resultlogin{
        var result : resultlogin = resultlogin()
        let unit = Unit_tool()
        
        
        let offset = unit.getoffset(FACTORY_KEY: FACTORY_KEY)
        let key = unit.getkey(FACTORY_KEY: FACTORY_KEY,offset: offset)
        let req = unit.getreq()
        let srtoff : String? = String(offset)
        let t = unit.getT(FACTORY_KEY: FACTORY_KEY, key: key,req: req , offset: offset)
        let urls = "http://" + domain + ":" + port+"/fac_init"
        
        
        print(urls)
        var request = URLRequest(url : URL(string: urls)!)
        request.httpMethod = "POST"// phuong thuc truyen
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "&fid=" + FACTORY_ID + "&o=" + srtoff! + "&t=" + t
        
        
        print("bodydata:  " + bodyData)
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        do{
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
                
                
                let decrypted = unit.Aes_decrypt(key: key, responseString: responseString!)
                let characters = decrypted.map { Character(UnicodeScalar($0)) }
                let b = String(Array(characters))
                print(b)
                let res = unit.convertToDictionary(text: b)!
                
                result.iv = res["iv"] as! String
                result.Key = res["key"] as! String
                result.rnd = res["rnd"] as! String
                result.sid = res["sid"] as! String
                result.sn = res["sn"] as! Int64
                
                
                
            }
            
            task.resume()
        }catch{
            
        }
        
        return result
    }
    @IBAction func bt_change_server(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaddata()
    
        
        
    
        
       

    }
    func aaaaaa()  {
        let urls = "http://10.20.1.7:4000/api/get-all-restaurent"
        
        var request = URLRequest(url : URL(string: urls)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")// kieu du lieu truyen len server
        request.addValue("access_token 939380ba-1f34-4e2b-84ee-019ae2a7cc7b", forHTTPHeaderField: "Authorization")// them xac thuwc vao header
        request.httpMethod = "POST"// phuong thuc truyen
        let json  = ["group_id":1] //data truyen len server
        let jsonData = try? JSONSerialization.data(withJSONObject: json)// convert data sang dang json
        
        request.httpBody = jsonData // add data vao body
      
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
    
        
    func loaddata() {
        
        var arrayserver: Array<SeverVinnet> = sql.getallserver()
        for i in (0..<arrayserver.count){
            combobox_choose_server.addItem(withObjectValue: arrayserver[i].domain)
        }
        var arraycus: Array<CustomerVinnet> = sql.getallcustomer()
        for i in (0..<arraycus.count){
            combobox_choose_customer.addItem(withObjectValue: arraycus[i].name)
        }
        
        print("akey phai co it nhat 6 ky tu")
        switch check_akey.state {
        case NSOnState:
            Ed_akey.stringValue = unit_auto.autogenerateAkeyinttohex()
            print("on akey")
        case NSOffState :
            Ed_akey.stringValue = ""
            print("off akey")
        default:
            print("default")
            
            
        }
        
    }
    
    
}


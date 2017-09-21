//
//  ConnectLogin.swift
//  ToolKids
//
//  Created by hungdn on 9/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
import SharkORM
import CryptoSwift
import SwiftyJSON
class ConnecttoServer: Any {
    
    
    func httpconnecserver(FACTORY_ID : String, FACTORY_KEY :String , domain : String , port :String) -> resultlogin{
        var result : resultlogin = resultlogin()
        let unit = Unit_tool()
        
        
        let offset = unit.getoffset(FACTORY_KEY: FACTORY_KEY)
        let key = unit.getkey(FACTORY_KEY: FACTORY_KEY,offset: offset)
        let req = unit.getreq()
        let srtoff : String? = String(offset)
        let t = unit.getT(FACTORY_KEY: FACTORY_KEY, key: key,req: req , offset: offset)
        let urls = "http://" + domain + ":" + port+"/fac_init"
        
        var request = URLRequest(url : URL(string: urls)!)
        request.httpMethod = "POST"// phuong thuc truyen
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyData = "&fid=" + FACTORY_ID + "&o=" + srtoff! + "&t=" + t
        
        
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
            
        
                let decrypted = unit.Aes_decrypt(key: key, responseString: responseString!)
                let characters = decrypted.map { Character(UnicodeScalar($0)) }
                let b = String(Array(characters))
                print(b)
                let res = unit.convertToDictionary(text: b)!
            
            result.iv = res["iv"] as! String
            result.Key = res["key"] as! String
            result.rnd = res["rnd"] as! String
            result.sid = res["sid"] as! String
            result.sn = res["sn"] as! String
                
            
            
        }
        task.resume()
        
        return result
    }
    
    func genQRcode(sever : SeverVinnet, reslogin : resultlogin , device_info : Device_Info) {
        let unit = Unit_tool()
        
        
        
        let urls = "http://" + sever.domain! + ":" + sever.port!+"/gen_qr_action"
        var sn : Int
        
        var request = URLRequest(url : URL(string: urls)!)
        request.httpMethod = "POST"// phuong thuc truyen
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        req = {
//            'pid':ptuid, 'akey': akey, 'sn': (sn+1), 'imei': imei, 'iccid': iccid, 'imsi': imsi, 'rnd': rnd,
//            'mcc': mcc, 'mnc': mnc, 'cdma_tid': cdma_tid, 'uimid': uimid, 'esn': esn, 'meid': meid, 'area_code': area_code
//        }

        var req = String("{" + '"pid"' + device_info.ptuid + ',"akey"' + device_info.akey +
            ',"sn"'
            + "}")
        let bodyData = "&fid=" + FACTORY_ID + "&o=" + srtoff! + "&t=" + t
        
        
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
            
            
            let decrypted = unit.Aes_decrypt(key: key, responseString: responseString!)
            let characters = decrypted.map { Character(UnicodeScalar($0)) }
            let b = String(Array(characters))
            print(b)
            let res = unit.convertToDictionary(text: b)!
            
            result.iv = res["iv"] as! String
            result.Key = res["key"] as! String
            result.rnd = res["rnd"] as! String
            result.sid = res["sid"] as! String
            result.sn = res["sn"] as! String
            
            
            
        }
        task.resume()
    
    }
    
    
}

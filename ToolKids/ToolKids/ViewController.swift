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

        let Id : Int? = (combobox_choose_server.indexOfSelectedItem + 1)
        print(combobox_choose_customer.indexOfSelectedItem)
        let server = sql.getseverbyId(Id: Id!)
        
        switch check_ptuid.state {
        case NSOnState:
        Ed_ptuid.stringValue = unit_auto.autoincrementptuid(str: Ed_ptuid.stringValue)
        case NSOffState:
            print("off ptuid")
        default:
            print("mixed")
        }
        
        
        switch check_akey.state {
        case NSOnState:
            Ed_akey.stringValue = unit_auto.autogenerateAkeyinttohex()
            print("on akey")
        case NSOffState :
            print("off akey")
        default:
            print("default")
            
           
        }
        
        
        let reslogin = csever.httpconnecserver(FACTORY_ID: server.user!, FACTORY_KEY: server.pass!, domain: server.domain!, port: server.port!)
        
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
        device.sn = String(Int(reslogin.sn!)! + 1)
        device.rnd = reslogin.rnd
        device.iccid = ""
        device.imsi = ""
        
    csever.genQRcode(sever: server, reslogin: reslogin, device_info: device)
        
    }
    
    @IBAction func bt_change_server(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaddata()
        
        
    
        
       

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
        
    }
    
    
}


//
//  AddNewServer.swift
//  ToolKid
//
//  Created by Doan Ngoc Hung on 9/18/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Cocoa
import SharkORM

class AddNewServer: NSViewController {
    
    
    var domain,port,username, password : String?
    var box : NSComboBox? = nil
    @IBOutlet weak var error: NSTextField!
    @IBOutlet weak var Ed_domain: NSTextField!
    
    @IBOutlet weak var Ed_port: NSTextField!
    
    @IBOutlet weak var Ed_username: NSTextField!
    
    @IBOutlet weak var Ed_password: NSSecureTextField!
    
    @IBAction func bt_add(_ sender: Any) {
        domain = Ed_domain.stringValue
        port = Ed_port.stringValue
        username = Ed_username.stringValue
        password = Ed_password.stringValue
        
        if(domain==""||port==""||username==""||password==""){
            
            error.isHidden =  false
            error.textColor = #colorLiteral(red: 0.9793023467, green: 0.1461903751, blue: 0.1501595378, alpha: 1)
            error.stringValue = "Bạn phải nhập đầy đủ thông tin"
            
        }else{
            var newServer = SeverVinnet()
            
            newServer.domain=domain
            newServer.port=port
            newServer.user=username
            newServer.pass=password
            newServer.commit()
            box?.addItem(withObjectValue: newServer.domain)
            
            error.isHidden = false
            error.textColor = #colorLiteral(red: 0.02910924889, green: 0.1983904541, blue: 1, alpha: 1)
            error.stringValue = "Thêm server thành công"
            Ed_domain.stringValue = ""
            Ed_port.stringValue = ""
            Ed_username.stringValue = ""
            Ed_password.stringValue = ""
        }
        
    }
    
    
    @IBAction func bt_cancle(_ sender: Any) {
        
        
        self.dismissViewController(self)
        
    }
    override func viewWillAppear() {
        box = self.representedObject as! NSComboBox
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
}

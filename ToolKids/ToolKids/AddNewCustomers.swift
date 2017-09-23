//
//  AddNewCustomers.swift
//  ToolKid
//
//  Created by Doan Ngoc Hung on 9/18/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Cocoa

class AddNewCustomers: NSViewController {
    
    var name : String?
    var key : String?
    var box : NSComboBox? = nil
    @IBOutlet weak var Ed_key: NSTextField!
    @IBOutlet weak var Ed_name: NSTextField!
    @IBOutlet weak var notifiaction: NSTextField!
    
    @IBAction func bt_cancel(_ sender: Any) {
        
        self.dismissViewController(self)
    }
    
    @IBAction func bt_add(_ sender: Any) {
        name = Ed_name.stringValue
        key = Ed_key.stringValue
        
        if(name == "" || key == ""){
            notifiaction.isHidden =  false
            notifiaction.textColor = #colorLiteral(red: 0.9793023467, green: 0.1461903751, blue: 0.1501595378, alpha: 1)
            notifiaction.stringValue = "Bạn phải nhập đầy đủ thông tin"
        }else{
            var newCustomer = CustomerVinnet()
            
            newCustomer.name = name
            newCustomer.key = key
            newCustomer.commit()
            box?.addItem(withObjectValue: newCustomer.name)
            
            notifiaction.isHidden = false
            notifiaction.textColor = #colorLiteral(red: 0.02910924889, green: 0.1983904541, blue: 1, alpha: 1)
            notifiaction.stringValue = "Thêm customer thành công"
            Ed_name.stringValue = ""
            Ed_key.stringValue = ""
        }
        
    }
    override func viewWillAppear() {
        box = self.representedObject as! NSComboBox
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

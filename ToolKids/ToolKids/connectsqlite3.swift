//
//  connectsqlite3.swift
//  ToolKids
//
//  Created by hungdn on 9/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
import SharkORM
import CryptoSwift
import SwiftyJSON

class Connectsqlite3 : Any {
    
    
    
    func getallserver() -> Array<SeverVinnet> {
    
        var arrayserver: Array<SeverVinnet> = Array<SeverVinnet>()
        let rs: SRKResultSet = SeverVinnet.query().fetch()
        for var item001 in rs{
            var new01 = SeverVinnet()
            new01.domain = (item001 as! SeverVinnet).domain
            new01.port = (item001 as! SeverVinnet).port
            new01.user = (item001 as! SeverVinnet).user
            new01.pass = (item001 as! SeverVinnet).pass
            
            print(item001)
            arrayserver.append(new01)
        }
        
        return arrayserver
    }
    func getallcustomer() -> Array<CustomerVinnet> {
        
        var arraycus: Array<CustomerVinnet> = Array<CustomerVinnet>()
        let rscus: SRKResultSet = CustomerVinnet.query().fetch()
        for var item001 in rscus{
            var new01 = CustomerVinnet()
            new01.name = (item001 as! CustomerVinnet).name
            new01.key = (item001 as! CustomerVinnet).key
            
            
            arraycus.append(new01)
        }
        
        return arraycus
    }
    
    func getseverbyId(Id : Int) -> SeverVinnet {
        
        var results = SeverVinnet.query()
            .where(withFormat: "Id = %@", withParameters: [Id])
            .limit(99)
            .fetch()
        let server = SeverVinnet()
        for item001 in results!{
        
            server.domain = (item001 as! SeverVinnet).domain
            server.port = (item001 as! SeverVinnet).port
            server.user = (item001 as! SeverVinnet).user
            server.pass = (item001 as! SeverVinnet).pass
            break
    
        }

        return server
    }
    
    
}

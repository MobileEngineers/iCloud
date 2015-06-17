//
//  AvaliacaoCloud.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CloudKit

class AvaliacaoCloud: NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String!
    var check: NSNumber!
    var data: NSDate!
    var materia: String?
    var nota: Double?
    
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
            
        self.nome = record.objectForKey("Name") as! String
        self.check = record.objectForKey("check") as! NSNumber
        self.data = record.objectForKey("data") as! NSDate
        self.materia = record.objectForKey("materia") as? String
        self.nota = record.objectForKey("nota") as? Double
    }

}

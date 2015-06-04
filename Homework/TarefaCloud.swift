//
//  TarefaCloud.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CloudKit

class TarefaCloud: NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String!
    var check: NSNumber!
    var data: NSDate!
    var materia: NSString?
    var nota: NSNumber?
    
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
        
        self.nome = record.objectForKey("") as! String
        self.check = record.objectForKey("") as! NSNumber
        self.data = record.objectForKey("") as! NSDate
        self.materia = record.objectForKey("") as? String
        self.nota = record.objectForKey("") as? NSNumber
    }

}

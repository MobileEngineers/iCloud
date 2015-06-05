//
//  DisciplinaCloud.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 04/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CloudKit

class DisciplinaCloud: NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String!
    
    
    init(record : CKRecord, database: CKDatabase)
    {
        self.record = record
        self.database = database
        
        self.nome = record.objectForKey("") as! String
    }

}

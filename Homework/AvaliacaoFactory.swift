//
//  AvaliacaoFactory.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData

class AvaliacaoFactory: NSObject {
    
    static func createAvaliacao(nomeFaculdade: String, favorito: NSNumber) {
        let contexto = (UIApplication.sharedApplication().delegate as! CoreData).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Faculdade", inManagedObjectContext: contexto!)
        let faculdade = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Avaliacao
        
        
        (UIApplication.sharedApplication().delegate as! CoreData).saveContext()
    }
    
    
}

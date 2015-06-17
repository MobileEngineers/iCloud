//
//  DisciplinaFactory.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit
import CoreData

class DisciplinaFactory: NSObject {
    
    static func createDisciplina(nomeFaculdade: String, favorito: NSNumber) {
        let contexto = (UIApplication.sharedApplication().delegate as! CoreData).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Disciplina", inManagedObjectContext: contexto!)
        let faculdade = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Disciplina
        
        
        (UIApplication.sharedApplication().delegate as! CoreData).saveContext()
    }
    
    
}

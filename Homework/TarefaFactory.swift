//
//  TarefaFactory.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//
import UIKit
import CoreData

class TarefaFactory: NSObject {
    
    static func createTarefa(nomeFaculdade: String, favorito: NSNumber) {
        let contexto = (UIApplication.sharedApplication().delegate as! CoreData).managedObjectContext
        let entidade = NSEntityDescription.entityForName("Tarefa", inManagedObjectContext: contexto!)
        let faculdade = NSManagedObject(entity: entidade!, insertIntoManagedObjectContext: contexto) as! Trabalho
        
        
        (UIApplication.sharedApplication().delegate as! CoreData).saveContext()
    }
    
    
}

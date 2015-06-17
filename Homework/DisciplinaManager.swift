//
//  DisciplinaManager.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import CoreData
import UIKit

public class DisciplinaManager {
    static let sharedInstance:DisciplinaManager = DisciplinaManager()
    static let entityName:String = "Disciplina"
    lazy var managedContext:NSManagedObjectContext = {
        var coreData = UIApplication.sharedApplication().delegate as! CoreData
        var c = coreData.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newDisciplina() -> Disciplina {
        return NSEntityDescription.insertNewObjectForEntityForName(DisciplinaManager.entityName, inManagedObjectContext: managedContext) as! Disciplina
    }
    
    func salvarDisciplina() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findDisciplina() -> [Disciplina] {
        let fetchRequest = NSFetchRequest(entityName: DisciplinaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return [Disciplina]()
    }
    
    func deletarDisciplina(vestibular: Disciplina) {
        managedContext.delete(vestibular)
    }
    
}

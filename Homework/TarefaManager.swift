//
//  TarefaManager.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import CoreData
import UIKit

public class TarefaManager {
    static let sharedInstance:TarefaManager = TarefaManager()
    static let entityName:String = "Tarefa"
    lazy var managedContext:NSManagedObjectContext = {
        var coreData = UIApplication.sharedApplication().delegate as! CoreData
        var c = coreData.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novaTarefa() -> Trabalho {
        return NSEntityDescription.insertNewObjectForEntityForName(TarefaManager.entityName, inManagedObjectContext: managedContext) as! Trabalho
    }
    
    func salvarTarefa() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findTarefa() -> [Trabalho] {
        let fetchRequest = NSFetchRequest(entityName: TarefaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Trabalho] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return [Trabalho]()
    }
    
    func deletarTarefa(vestibular: Trabalho) {
        managedContext.delete(vestibular)
    }
    
}

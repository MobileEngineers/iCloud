//
//  AvaliacaoManager.swift
//  Homework
//
//  Created by Ana Elisa Pessoa Aguiar on 17/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import CoreData
import UIKit

public class AvaliacaoManager {
    static let sharedInstance:AvaliacaoManager = AvaliacaoManager()
    static let entityName:String = "Avaliacao"
    lazy var managedContext:NSManagedObjectContext = {
        var coreData = UIApplication.sharedApplication().delegate as! CoreData
        var c = coreData.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newAvaliacao() -> Avaliacao {
        return NSEntityDescription.insertNewObjectForEntityForName(AvaliacaoManager.entityName, inManagedObjectContext: managedContext) as! Avaliacao
    }
    
    func salvarAvaliacao() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func findAvaliacao() -> [Avaliacao] {
        let fetchRequest = NSFetchRequest(entityName: AvaliacaoManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Avaliacao] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return [Avaliacao]()
    }
    
    func deleteAvaliacao(vestibular: Avaliacao) {
        managedContext.delete(vestibular)
    }
    
}

//
//  Trabalho.swift
//  
//
//  Created by Isaías Lima on 16/06/15.
//
//

import Foundation
import CoreData

class Trabalho: NSManagedObject {

    @NSManaged var check: Bool
    @NSManaged var data: NSDate
    @NSManaged var descricao: String
    @NSManaged var nome: String
    @NSManaged var eventIdentifier: String
    @NSManaged var nota: Double
    @NSManaged var disciplina: Disciplina

}

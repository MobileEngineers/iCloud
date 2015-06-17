//
//  Avaliacao.swift
//  
//
//  Created by Isaías Lima on 16/06/15.
//
//

import Foundation
import CoreData

class Avaliacao: NSManagedObject {

    @NSManaged var check: Bool
    @NSManaged var data: NSDate
    @NSManaged var materia: String
    @NSManaged var nome: String
    @NSManaged var nota: Double
    @NSManaged var disciplina: Disciplina

}
